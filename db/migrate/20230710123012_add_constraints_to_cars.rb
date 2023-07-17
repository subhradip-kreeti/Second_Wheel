# frozen_string_literal: true

# Add validations to car
class AddConstraintsToCars < ActiveRecord::Migration[6.1]
  def change
    change_column_null :cars, :brand_id, false
    change_column_null :cars, :car_model_id, false
    change_column_null :cars, :user_id, false
    change_column_null :cars, :branch_id, false
    change_column_null :cars, :variant, false
    change_column_null :cars, :kilometer_driven, false
    change_column_null :cars, :reg_year, false
    change_column_null :cars, :reg_state, false
    change_column_null :cars, :reg_no, false
    add_index :cars, :reg_no, unique: true
  end
end
