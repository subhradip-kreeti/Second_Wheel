# frozen_string_literal: true

# Notification Model
class Notification < ApplicationRecord
  belongs_to :user
  validates :message, presence: true
end
