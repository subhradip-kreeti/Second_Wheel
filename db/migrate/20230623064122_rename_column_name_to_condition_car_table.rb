# frozen_string_literal: true

# rename name column of car to 'condition'
class RenameColumnNameToConditionCarTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :cars, :name, :condition
  end
end
