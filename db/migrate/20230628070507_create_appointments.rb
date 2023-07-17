# frozen_string_literal: true

# create appointment table
class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
