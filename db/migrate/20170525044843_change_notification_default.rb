class ChangeNotificationDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :notifications, :enabled, from: nil, to: true
    change_column_default :notifications, :taken_medicine, from: nil, to: false
  end
end
