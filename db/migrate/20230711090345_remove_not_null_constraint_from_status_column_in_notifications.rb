# frozen_string_literal: true

# remove not null from notification
class RemoveNotNullConstraintFromStatusColumnInNotifications < ActiveRecord::Migration[6.1]
  def change
    change_column_null :notifications, :status, true
  end
end
