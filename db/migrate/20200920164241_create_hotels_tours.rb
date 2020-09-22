class CreateHotelsTours < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels_tours do |t|
      t.references :hotel, null: false, foreign_key: true
      t.references :tour, null: false, foreign_key: true
      t.timestamps
    end
  end
end
