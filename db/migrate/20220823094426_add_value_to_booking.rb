class AddValueToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :value, :integer
    add_column :bookings, :status, :string
  end
end
