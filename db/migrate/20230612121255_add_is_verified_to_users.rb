# frozen_string_literal: true

# Add is_verified column to user
class AddIsVerifiedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_verified, :boolean, default: false
  end
end
