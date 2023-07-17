# frozen_string_literal: true

# Add mobile_no column to user
class AddMobileNoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mobile_no, :string
  end
end
