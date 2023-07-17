# frozen_string_literal: true

# Add validations to city
class AddConstraintsToCity < ActiveRecord::Migration[6.1]
  def change
    change_column :cities, :name, :string, null: false
    change_column :cities, :state, :string, null: false
    add_index :cities, :name, unique: true
  end
end
