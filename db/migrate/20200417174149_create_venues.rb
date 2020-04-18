class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.integer :rows
      t.integer :columns

      t.timestamps
    end
  end
end
