# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Brand, type: :model do
  context 'validations' do
    it 'validates presence of name' do
      brand = Brand.new(name: nil)
      expect(brand.valid?).to eq(false)
      expect(brand.errors[:name]).to include("can't be blank")
    end

    it 'validates uniqueness of name' do
      create(:brand, name: 'Existing Brand')
      brand = Brand.new(name: 'Existing Brand')
      expect(brand.valid?).to eq(false)
      expect(brand.errors[:name]).to include('has already been taken')
    end
  end

  context 'associations' do
    it 'has many car_models' do
      association = described_class.reflect_on_association(:car_models)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many cars' do
      association = described_class.reflect_on_association(:cars)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  context 'inserting new data' do
    it 'creates a new brand' do
      brand = Brand.create(name: 'Example Brand')
      expect(brand.persisted?).to eq(true)
      expect(Brand.count).to eq(1)
    end
  end
end
# rubocop:enable Metrics/BlockLength
