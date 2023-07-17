# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Branch, type: :model do
  context 'validations' do
    it 'validates presence of name' do
      branch = Branch.new(name: nil, address: 'Sample Address', longitude: 'Sample Longitude',
                          latitude: 'Sample Latitude', city_id: 1)
      expect(branch.valid?).to eq(false)
      expect(branch.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of address' do
      branch = Branch.new(name: 'Sample Name', address: nil, longitude: 'Sample Longitude',
                          latitude: 'Sample Latitude', city_id: 1)
      expect(branch.valid?).to eq(false)
      expect(branch.errors[:address]).to include("can't be blank")
    end

    it 'validates presence of longitude' do
      branch = Branch.new(name: 'Sample Name', address: 'Sample Address', longitude: nil, latitude: 'Sample Latitude',
                          city_id: 1)
      expect(branch.valid?).to eq(false)
      expect(branch.errors[:longitude]).to include("can't be blank")
    end

    it 'validates presence of latitude' do
      branch = Branch.new(name: 'Sample Name', address: 'Sample Address', longitude: 'Sample Longitude', latitude: nil,
                          city_id: 1)
      expect(branch.valid?).to eq(false)
      expect(branch.errors[:latitude]).to include("can't be blank")
    end

    it 'validates presence of city_id' do
      branch = Branch.new(name: 'Sample Name', address: 'Sample Address', longitude: 'Sample Longitude',
                          latitude: 'Sample Latitude', city_id: nil)
      expect(branch.valid?).to eq(false)
      expect(branch.errors[:city_id]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'belongs to a city' do
      association = described_class.reflect_on_association(:city)
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
