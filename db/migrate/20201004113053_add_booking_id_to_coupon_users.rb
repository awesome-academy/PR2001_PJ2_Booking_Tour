class AddBookingIdToCouponUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_users, :booking_tour_id, :integer
  end
end
