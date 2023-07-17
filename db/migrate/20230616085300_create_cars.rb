# frozen_string_literal: true

# create cars table
class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :name
      t.references :brand, null: false, foreign_key: true
      t.references :car_model, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :branch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
