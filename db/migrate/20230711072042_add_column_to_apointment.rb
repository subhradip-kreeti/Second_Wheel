# frozen_string_literal: true

# Add appointment_id for appointment table
class AddColumnToApointment < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :appointment_id, :string
  end
end
