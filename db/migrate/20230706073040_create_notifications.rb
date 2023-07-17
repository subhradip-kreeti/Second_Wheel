# frozen_string_literal: true

# Create Notification table
class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.text :message
      t.boolean :status

      t.timestamps
    end
  end
end
