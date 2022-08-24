class RemoveCoordinateFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :city, :string
    remove_column :cars, :country, :string
    remove_column :cars, :zipcode, :string
  end
end
