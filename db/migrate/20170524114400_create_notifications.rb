class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.int :user_id
      t.string :wday
      t.string :country
      t.int :medicine_id
      t.string :medicine_time
      t.int :medicine_pill_num
      t.boolean :enabled
      t.boolean :taken_medicine

      t.timestamps
    end
  end
end
