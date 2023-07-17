# frozen_string_literal: true

# Add validations to user
class AddValidationsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :email, :string, null: false
    add_index :users, :email, unique: true

    change_column :users, :password_digest, :string, null: false

    change_column :users, :mobile_no, :string, null: false

    change_column :users, :role, :string, null: false

    change_column :users, :name, :string, null: false
  end
end
