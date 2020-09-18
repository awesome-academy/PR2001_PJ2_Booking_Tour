class CreateBookingTours < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_tours do |t|
      t.references :tour_detail, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.integer :coupon
      t.integer :quantity
      t.float :price_total
      t.integer :booking_status, null: false, default: 1
      t.integer :payment_status, null: false, default: 0
      t.timestamps
    end
  end
end
