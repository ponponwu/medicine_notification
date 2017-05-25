class CreateMedicines < ActiveRecord::Migration[5.0]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :info

      t.timestamps
    end
  end
end
