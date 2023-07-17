# frozen_string_literal: true

# Add token_expire column to user
class TokenExpireToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :token_expire, :string
  end
end
