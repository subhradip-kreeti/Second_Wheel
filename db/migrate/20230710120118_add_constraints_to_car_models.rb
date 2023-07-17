# frozen_string_literal: true

# Add validations to car
class AddConstraintsToCarModels < ActiveRecord::Migration[6.1]
  def change
    change_column :car_models, :name, :string, null: false
    add_index :car_models, :name, unique: true
  end
end
