class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.string :row
      t.integer :column
      t.string :label
      t.boolean :available

      t.timestamps
    end
  end
end
