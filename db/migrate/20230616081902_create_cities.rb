# frozen_string_literal: true

# create city table
class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state

      t.timestamps
    end
  end
end
