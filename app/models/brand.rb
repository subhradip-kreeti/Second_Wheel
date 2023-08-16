# frozen_string_literal: true

# Brand model
class Brand < ApplicationRecord
  has_many :car_models, dependent: :destroy
  has_many :cars, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
