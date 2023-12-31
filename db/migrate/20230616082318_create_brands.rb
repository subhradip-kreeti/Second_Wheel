# frozen_string_literal: true

# create brand table
class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.string :name

      t.timestamps
    end
  end
end
