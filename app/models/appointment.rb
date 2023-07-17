# frozen_string_literal: true

# Appointment Model
class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :car
  validates :date, :user_id, :car_id, presence: true
  validate :date_must_be_in_future
  validates :appointment_id, uniqueness: true

  enum seller_status: { Sell_Pending: 'Sell_Pending', Sell_Processing: 'Sell_Processing',
                        Sell_Investigating: 'Sell_Investigating', Ready_for_Sell: 'Ready_for_Sell',
                        Sold: 'Sold', Reject: 'Reject' }
  enum buyer_status: { Buy_Pending: 'Buy_Pending', Buy_Processing: 'Buy_Processing',
                       Buy_Investigating: 'Buy_Investigating', Ready_to_Buy: 'Ready_to_Buy',
                       Bought: 'Bought', Buy_Request_Cancelled: 'Buy_Request_Cancelled' }

  def date_must_be_in_future
    return if date.blank?

    errors.add(:date, 'must be a present or future date') if date < Date.today
  end
end
