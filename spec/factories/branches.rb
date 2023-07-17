# frozen_string_literal: true

FactoryBot.define do
  factory :branch do
    name { 'Sample Branch' }
    address { 'Sample Address' }
    map_link { 'Sample Map Link' }
    longitude { 'Sample Longitude' }
    latitude { 'Sample Latitude' }
    association :city, factory: :city
  end
end
