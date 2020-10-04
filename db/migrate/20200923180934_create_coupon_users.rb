class CreateCouponUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :coupon_users do |t|
      t.integer :user_id
      t.integer :coupon_id
      t.timestamps
    end
  end
end
