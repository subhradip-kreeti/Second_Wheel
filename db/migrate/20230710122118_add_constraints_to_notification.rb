# frozen_string_literal: true

# Add validations to Notification
class AddConstraintsToNotification < ActiveRecord::Migration[6.1]
  def change
    change_column :notifications, :status, :boolean, null: false
    change_column :notifications, :message, :text, null: false
  end
end
