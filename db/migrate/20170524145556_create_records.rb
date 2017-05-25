class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.int :user_id
      t.int :medicine_id
      t.int :notification_id

      t.timestamps
    end
  end
end
