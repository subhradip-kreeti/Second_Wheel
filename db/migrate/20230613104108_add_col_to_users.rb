# frozen_string_literal: true

# Add name column to user
class AddColToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
  end
end
