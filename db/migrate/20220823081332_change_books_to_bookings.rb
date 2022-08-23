class ChangeBooksToBookings < ActiveRecord::Migration[7.0]
  def change
    rename_table :books, :bookings
  end
end
