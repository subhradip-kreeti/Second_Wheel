# frozen_string_literal: true

# Add price column to car
class AddColumnToCars < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :price, :string
  end
end
