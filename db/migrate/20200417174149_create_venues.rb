class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name, null: false, default: "Unkown"
      t.integer :rows, null: false, default: 0
      t.integer :columns, null: false, default: 0

      t.timestamps
    end
  end
end
