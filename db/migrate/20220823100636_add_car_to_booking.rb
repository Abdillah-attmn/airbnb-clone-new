class AddCarToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :car, null: false, foreign_key: true
  end
end
