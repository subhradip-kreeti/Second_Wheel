# frozen_string_literal: true

# Add attributes of car
class AddAttributesToCars < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :variant, :string
    add_column :cars, :kilometer_driven, :string
    add_column :cars, :reg_year, :string
    add_column :cars, :reg_state, :string
  end
end
