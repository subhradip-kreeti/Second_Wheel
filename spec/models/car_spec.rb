# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'validations' do
    let(:brand) { Brand.create(name: 'Sample Brand') }
    let(:car_model) { CarModel.create(name: 'Sample Car Model') }
    let(:user) { User.create(name: 'Sample User') }
    let(:branch) { Branch.create(name: 'Sample Branch') }

    it 'validates presence of reg_no' do
      car = Car.new(reg_no: nil, brand:, car_model:, user:, branch:, variant: 'Petrol',
                    kilometer_driven: '1-10000', reg_year: '2021', reg_state: 'West Bengal')
      expect(car.valid?).to eq(false)
      expect(car.errors[:reg_no]).to include("can't be blank")
    end

    it 'validates presence of brand_id' do
      car = Car.new(reg_no: 'ABC123', brand_id: nil, car_model:, user:, branch:,
                    variant: 'Petrol', kilometer_driven: '1-10000', reg_year: '2021', reg_state: 'West Bengal')
      expect(car.valid?).to eq(false)
      expect(car.errors[:brand_id]).to include("can't be blank")
    end

    it 'validates presence of car_model_id' do
      car = Car.new(reg_no: 'ABC123', brand:, car_model_id: nil, user:, branch:, variant: 'Petrol',
                    kilometer_driven: '1-10000', reg_year: '2021', reg_state: 'West Bengal')
      expect(car.valid?).to eq(false)
      expect(car.errors[:car_model_id]).to include("can't be blank")
    end

    it 'validates presence of user_id' do
      car = Car.new(reg_no: 'ABC123', brand:, car_model:, user_id: nil, branch:,
                    variant: 'Petrol', kilometer_driven: '1-10000', reg_year: '2021', reg_state: 'West Bengal')
      expect(car.valid?).to eq(false)
      expect(car.errors[:user_id]).to include("can't be blank")
    end

    it 'validates presence of branch_id' do
      car = Car.new(reg_no: 'ABC123', brand:, car_model:, user:, branch_id: nil,
                    variant: 'Petrol', kilometer_driven: '1-10000', reg_year: '2021', reg_state: 'West Bengal')
      expect(car.valid?).to eq(false)
      expect(car.errors[:branch_id]).to include("can't be blank")
    end

    it 'validates presence of variant' do
      car = Car.new(reg_no: 'ABC123', brand:, car_model:, user:, branch:, variant: nil,
                    kilometer_driven: '1-10000', reg_year: '2021', reg_state: 'West Bengal')
      expect(car.valid?).to eq(false)
      expect(car.errors[:variant]).to include("can't be blank")
    end

    it 'validates presence of kilometer_driven' do
      car = Car.new(reg_no: 'ABC123', brand:, car_model:, user:, branch:,
                    variant: 'Petrol', kilometer_driven: nil, reg_year: '2021', reg_state: 'West Bengal')
      expect(car.valid?).to eq(false)
      expect(car.errors[:kilometer_driven]).to include("can't be blank")
    end

    it 'validates presence of reg_year' do
      car = Car.new(reg_no: 'ABC123', brand:, car_model:, user:, branch:,
                    variant: 'Petrol', kilometer_driven: '1-10000', reg_year: nil, reg_state: 'West Bengal')
      expect(car.valid?).to eq(false)
      expect(car.errors[:reg_year]).to include("can't be blank")
    end

    it 'validates presence of reg_state' do
      car = Car.new(reg_no: 'ABC123', brand:, car_model:, user:, branch:,
                    variant: 'Petrol', kilometer_driven: '1-10000', reg_year: '2021', reg_state: nil)
      expect(car.valid?).to eq(false)
      expect(car.errors[:reg_state]).to include("can't be blank")
    end
  end
end
# rubocop:enable Metrics/BlockLength
