# frozen_string_literal: true

# create branches table
class CreateBranches < ActiveRecord::Migration[6.1]
  def change
    create_table :branches do |t|
      t.string :name
      t.string :address
      t.string :map_link
      t.string :longitude
      t.string :latitude
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
