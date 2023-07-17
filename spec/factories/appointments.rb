# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    date { Date.today }
    user
    car
    status { 'Scheduled' }
    appointment_id { SecureRandom.uuid }
  end
end
