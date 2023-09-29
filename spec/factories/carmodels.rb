# frozen_string_literal: true

FactoryBot.define do
  factory :car_model do
    name { 'Example Car Model' }

    trait :with_brand do
      association :brand, factory: :brand
    end
  end
end
