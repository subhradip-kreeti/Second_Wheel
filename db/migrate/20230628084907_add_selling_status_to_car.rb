# frozen_string_literal: true

# Add selling_appointment_status column to car
class AddSellingStatusToCar < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :selling_appointment_status, :string
  end
end
