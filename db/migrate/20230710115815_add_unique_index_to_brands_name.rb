# frozen_string_literal: true

# Add validations to brand
class AddUniqueIndexToBrandsName < ActiveRecord::Migration[6.1]
  def change
    change_column :brands, :name, :string, null: false
    add_index :brands, :name, unique: true
  end
end
