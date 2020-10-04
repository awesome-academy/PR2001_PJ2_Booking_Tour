class CreateHotelTours < ActiveRecord::Migration[6.0]
  def change
    create_table :hotel_tours do |t|
      t.references :hotel, null: false, foreign_key: true
      t.references :tour, null: false, foreign_key: true
      t.string :option
      t.timestamps
    end
  end
end
