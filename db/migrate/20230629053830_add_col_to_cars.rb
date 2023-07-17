# frozen_string_literal: true

# Add reg_no column to car
class AddColToCars < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :reg_no, :string
  end
end
