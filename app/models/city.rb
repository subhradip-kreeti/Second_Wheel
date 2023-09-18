# frozen_string_literal: true

# city model
class City < ApplicationRecord
  has_many :branch, dependent: :destroy

  validates :name, presence: true
  validates :state, presence: true
  validate :unique_name_state_combination

  private
  
  def unique_name_state_combination
    return if name.blank? || state.blank?

    existing_city = City.where('LOWER(name) = ? AND LOWER(state) = ?', name.downcase, state.downcase).first
    return unless existing_city && existing_city != self

    errors.add(:name, 'and state combination must be unique')
  end

end
