# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Appointment, type: :model do
  context 'validations' do
    it 'validates presence of date' do
      appointment = Appointment.new(date: nil, user_id: 1, car_id: 1)
      expect(appointment.valid?).to eq(false)
      expect(appointment.errors[:date]).to include("can't be blank")
    end

    it 'validates presence of user_id' do
      appointment = Appointment.new(date: Date.today, user_id: nil, car_id: 1)
      expect(appointment.valid?).to eq(false)
      expect(appointment.errors[:user_id]).to include("can't be blank")
    end

    it 'validates presence of car_id' do
      appointment = Appointment.new(date: Date.today, user_id: 1, car_id: nil)
      expect(appointment.valid?).to eq(false)
      expect(appointment.errors[:car_id]).to include("can't be blank")
    end
  end

  context 'custom validation' do
    it 'validates that the date is in the future' do
      appointment = Appointment.new(date: Date.yesterday, user_id: 1, car_id: 1)
      expect(appointment.valid?).to eq(false)
      expect(appointment.errors[:date]).to include('must be a present or future date')
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a car' do
      association = described_class.reflect_on_association(:car)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
# rubocop:enable Metrics/BlockLength
