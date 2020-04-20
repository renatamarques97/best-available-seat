class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.integer :rows, null: false
      t.integer :columns, null: false

      t.timestamps
    end
  end
end
