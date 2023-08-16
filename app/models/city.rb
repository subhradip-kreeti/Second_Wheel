# frozen_string_literal: true

# city model
class City < ApplicationRecord
  has_many :branch, dependent: :destroy

  validates :name, presence: true
  validates :state, presence: true
end
