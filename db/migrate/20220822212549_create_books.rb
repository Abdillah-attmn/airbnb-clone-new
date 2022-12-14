class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
