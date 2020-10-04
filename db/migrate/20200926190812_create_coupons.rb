class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :coupon_type
      t.integer :coupon_target_type
      t.integer :coupon_amount
      t.integer :coupon_target_id
      t.integer :coupon_use_count
      t.date :date_start
      t.date :date_end
      t.timestamps
    end
  end
end
