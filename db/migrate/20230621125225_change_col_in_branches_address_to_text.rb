# frozen_string_literal: true

# Add address to branches
class ChangeColInBranchesAddressToText < ActiveRecord::Migration[6.1]
  def change
    change_column :branches, :address, :text
  end
end
