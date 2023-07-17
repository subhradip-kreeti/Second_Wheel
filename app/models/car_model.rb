# frozen_string_literal: true

# CarModel model
class CarModel < ApplicationRecord
  belongs_to :brand
  has_many :cars, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :brand_id, presence: true
end
