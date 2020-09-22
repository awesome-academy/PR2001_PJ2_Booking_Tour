class CreateCouponsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons_users do |t|
      t.references :coupon, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :count_use_coupon
      t.timestamps
    end
  end
end
