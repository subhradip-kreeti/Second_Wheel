# frozen_string_literal: true

# Add validations to appointment
class AddConstraintsToAppointment < ActiveRecord::Migration[6.1]
  def change
    change_column :appointments, :date, :date, null: false
  end
end
