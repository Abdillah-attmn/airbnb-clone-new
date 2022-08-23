class RenameOfferToBooking < ActiveRecord::Migration[7.0]
  def change
    rename_table :offers, :cars
  end
end
