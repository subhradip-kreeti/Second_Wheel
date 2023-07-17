# frozen_string_literal: true

# Add image column to car
class AddColumnToCarsImage < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :image, :string
  end
end
