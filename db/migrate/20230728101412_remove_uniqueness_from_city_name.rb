# frozen_string_literal: true

# remove uniqueness from city name
class RemoveUniquenessFromCityName < ActiveRecord::Migration[6.1]
  def change
    remove_index :cities, :name  # Remove the unique index
  end
end
