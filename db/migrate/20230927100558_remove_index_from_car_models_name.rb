# frozen_string_literal: true

# db/migrate/xxxxxxxxxxxxxx_remove_index_from_car_models_name.rb
class RemoveIndexFromCarModelsName < ActiveRecord::Migration[6.0]
  def up
    remove_index :car_models, name: 'index_car_models_on_name'
  end

  def down
    add_index :car_models, :name, unique: true, name: 'index_car_models_on_name'
  end
end
