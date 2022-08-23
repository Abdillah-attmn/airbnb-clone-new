class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.string :content
      t.integer :price

      t.timestamps
    end
  end
end