# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    association :brand
    association :car_model
    association :user
    association :branch
    sequence(:reg_no) { |n| "ABC#{n}" }
    variant { 'Petrol' }
    kilometer_driven { '1-10000' }
    reg_year { '2021' }
    reg_state { 'west_bengal' }
    image { nil }
    price { '1000000' }
    selling_appointment_status { 'Sell_Pending' }
  end
end
