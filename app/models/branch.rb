# frozen_string_literal: true

# Branch Model
class Branch < ApplicationRecord
  belongs_to :city
  has_many :cars, dependent: :destroy

  validates :name, :address, :longitude, :latitude, :city_id, presence: true

  geocoded_by :address

  after_validation :geocode, if: :address_changed?
end
