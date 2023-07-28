# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  require 'securerandom'
  has_secure_password

  has_many :cars, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }, allow_blank: true
  validates :mobile_no, presence: true, length: { is: 10 }, format: { with: /\A[6-9]\d{9}\z/ }
  validates :role, presence: true
  validates :role, presence: true
  validates :name, presence: true

  before_create :generate_confirmation_token

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
    self.token_expire = Time.now + 1.minutes
  end
end
