# frozen_string_literal: true

# car model
# rubocop:disable Metrics/ClassLength, Layout/LineLength , Metrics/MethodLength
class Car < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :brand
  belongs_to :car_model
  belongs_to :user
  belongs_to :branch
  has_many :appointments, dependent: :destroy
  has_one_attached :image

  validate :valid_price_condition
  validates :reg_no, presence: true, uniqueness: true, format: { with: /\A[A-Z]{2}\d{2}[A-Z]{1,2}\d{4}\z/, message: 'is not in a valid format' }
  validates :brand_id, :car_model_id, :user_id, :branch_id, :variant, :kilometer_driven, :reg_year, :reg_state, :reg_no,
            presence: true
  validate :validate_image_format

  default_scope { order(created_at: :desc, reg_year: :asc) }
  scope :by_city, ->(city) { joins(branch: :city).where(cities: { name: city }) if city.present? }
  scope :by_brand, ->(brand) { joins(:brand).where(brands: { name: brand }) if brand.present? }
  scope :by_model, ->(model) { joins(car_model: :brand).where(car_models: { name: model }) if model.present? }
  scope :by_reg_year, ->(year) { where(reg_year: year) if year.present? }
  scope :by_variant, ->(variant) { where(variant:) if variant.present? }
  scope :by_reg_state, ->(state) { where(reg_state: state) if state.present? }
  scope :by_kilometer_driven, ->(kilometer_driven) { where(kilometer_driven:) if kilometer_driven.present? }
  scope :ordered_by_created_at, -> { order(:created_at) }

  enum condition: { Fair: 'Fair', Good: 'Good', Very_Good: 'Very Good', Excellent: 'Excellent' }
  enum variant: { Petrol: 'Petrol', Diesel: 'Diesel', CNG: 'CNG' }
  enum kilometer_driven: { '1-10000': 'range1', '10001-20000': 'range2', '20001-40000': 'range3', '40001-60000': 'range4',
                           'above 60000': 'range5' }
  enum reg_year: {
    '2001': '2001', '2002': '2002', '2003': '2003', '2004': '2004', '2005': '2005', '2006': '2006', '2007': '2007', '2008': '2008', '2009': '2009', '2010': '2010',
    '2011': '2011', '2012': '2012', '2013': '2013', '2014': '2014', '2015': '2015', '2016': '2016', '2017': '2017', '2018': '2018', '2019': '2019', '2020': '2020',
    '2021': '2021', '2022': '2022', '2023': '2023'
  }
  enum reg_state: {
    andaman_and_nicobar_islands: 'Andaman and Nicobar Islands',
    andhra_pradesh: 'Andhra Pradesh',
    arunachal_pradesh: 'Arunachal Pradesh',
    assam: 'Assam',
    bihar: 'Bihar',
    chandigarh: 'Chandigarh',
    chhattisgarh: 'Chhattisgarh',
    dadra_and_nagar_haveli: 'Dadra and Nagar Haveli',
    daman_and_diu: 'Daman and Diu',
    delhi: 'Delhi',
    goa: 'Goa',
    gujarat: 'Gujarat',
    haryana: 'Haryana',
    himachal_pradesh: 'Himachal Pradesh',
    jammu_and_kashmir: 'Jammu and Kashmir',
    jharkhand: 'Jharkhand',
    karnataka: 'Karnataka',
    kerala: 'Kerala',
    lakshadweep: 'Lakshadweep',
    madhya_pradesh: 'Madhya Pradesh',
    maharashtra: 'Maharashtra',
    manipur: 'Manipur',
    meghalaya: 'Meghalaya',
    mizoram: 'Mizoram',
    nagaland: 'Nagaland',
    odisha: 'Odisha',
    puducherry: 'Puducherry',
    punjab: 'Punjab',
    rajasthan: 'Rajasthan',
    sikkim: 'Sikkim',
    tamil_nadu: 'Tamil Nadu',
    telangana: 'Telangana',
    tripura: 'Tripura',
    uttar_pradesh: 'Uttar Pradesh',
    uttarakhand: 'Uttarakhand',
    west_bengal: 'West Bengal'
  }

  def valid_price_condition
    return unless price.present? && condition.present?

    price_without_commas = price.gsub(',', '').to_i

    return unless price_without_commas.present? && !valid_price_range?(price_without_commas, condition)

    errors.add(:price, 'is not within the valid price range for the selected condition')
  end

  def valid_price_range?(price, condition)
    case condition
    when 'Fair'
      price.between?(100_001, 125_000)
    when 'Good'
      price.between?(125_001, 150_000)
    when 'Very_Good'
      price.between?(150_001, 175_000)
    when 'Excellent'
      price.between?(175_001, 200_000)
    else
      false
    end
  end

  def validate_image_format
    return unless image.attached?
    return if image.content_type.starts_with?('image/')

    errors.add(:image, 'file must be an image')
  end

  def self.index_data
    __elasticsearch__.create_index! force: true
    Car.import
  end

  settings do
    mappings dynamic: false do
      indexes :brand_name, type: :text
      indexes :car_model_name, type: :text, analyzer: :english
      indexes :reg_no, type: :text, analyzer: :english
      indexes :variant, type: :text, analyzer: :english
      indexes :condition, type: :text, analyzer: :english
      indexes :reg_year, type: :text, analyzer: :english
      indexes :reg_state, type: :text, analyzer: :english
    end
  end

  def as_indexed_json(_options = {})
    {
      brand_name: brand.name,
      car_model_name: car_model.name,
      reg_no:,
      variant:,
      condition:,
      reg_year:,
      reg_state:
    }
  end

  def self.search_car(query)
    wildcards_query = query.split.map { |term| "*#{term}*" }.join(' ')

    response = search({
                        query: {
                          bool: {
                            must: [
                              {
                                query_string: {
                                  query: wildcards_query,
                                  fields: %i[brand_name car_model_name reg_no variant condition reg_year reg_state]
                                }
                              }
                            ]
                          }
                        }
                      })
    response.records
  end
end
# rubocop:enable Metrics/ClassLength, Layout/LineLength , Metrics/MethodLength
