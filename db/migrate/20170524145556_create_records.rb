class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.integer :user_id
      t.integer :medicine_id
      t.integer :notification_id

      t.timestamps
    end
  end
end
