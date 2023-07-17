# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe CarModel, type: :model do
  context 'validations' do
    it 'validates presence of name' do
      car_model = build(:car_model, name: nil, brand_id: 1)
      expect(car_model.valid?).to eq(false)
      expect(car_model.errors[:name]).to include("can't be blank")
    end

    it 'validates uniqueness of name' do
      create(:car_model, name: 'Existing Model')
      car_model = build(:car_model, name: 'existing model', brand_id: 1)
      expect(car_model.valid?).to eq(false)
      expect(car_model.errors[:name]).to include('has already been taken')
    end

    it 'validates presence of brand_id' do
      car_model = build(:car_model, name: 'Model', brand_id: nil)
      expect(car_model.valid?).to eq(false)
      expect(car_model.errors[:brand_id]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'belongs to a brand' do
      association = described_class.reflect_on_association(:brand)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many cars' do
      association = described_class.reflect_on_association(:cars)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end
# rubocop:enable Metrics/BlockLength
