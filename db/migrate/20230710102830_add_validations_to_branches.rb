# frozen_string_literal: true

# Add validations to branches
class AddValidationsToBranches < ActiveRecord::Migration[6.1]
  def change
    change_column :branches, :name, :string, null: false
    change_column :branches, :address, :text, null: false
    change_column :branches, :map_link, :string, null: false
    change_column :branches, :longitude, :string, null: false
    change_column :branches, :latitude, :string, null: false
    change_column :branches, :city_id, :bigint, null: false
  end
end
