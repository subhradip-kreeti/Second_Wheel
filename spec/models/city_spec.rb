# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  context 'validations' do
    it 'validates presence of name' do
      city = City.new(name: nil, state: 'Sample State')
      expect(city.valid?).to eq(false)
      expect(city.errors[:name]).to include("can't be blank")
    end

    it 'validates uniqueness of name' do
      create(:city, name: 'Existing City', state: 'Sample State')
      city = City.new(name: 'Existing City', state: 'Sample State')
      expect(city.valid?).to eq(false)
      expect(city.errors[:name]).to include('has already been taken')
    end

    it 'validates presence of state' do
      city = City.new(name: 'Sample City', state: nil)
      expect(city.valid?).to eq(false)
      expect(city.errors[:state]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'has many branches' do
      association = described_class.reflect_on_association(:branch)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end