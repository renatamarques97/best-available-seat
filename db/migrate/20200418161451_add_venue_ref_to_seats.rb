class AddVenueRefToSeats < ActiveRecord::Migration[6.0]
  def change
    add_reference :seats, :venue, null: false, foreign_key: true
  end
end
