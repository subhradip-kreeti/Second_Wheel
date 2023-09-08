# frozen_string_literal: true

# user factory
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    mobile_no { '9988774455' }
    password { 'password' }
    role { 'admin' }
  end
end
