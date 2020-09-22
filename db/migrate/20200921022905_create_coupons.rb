class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :coupon_type
      t.integer :coupon_target_type
      t.integer :coupon_amount
      t.integer :coupon_target_id
      t.integer :coupon_use_count
      t.date :coupon_start_date
      t.date :coup_end_date
      t.timestamps
    end
  end
end
