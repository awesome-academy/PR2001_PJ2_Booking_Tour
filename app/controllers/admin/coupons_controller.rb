class Admin::CouponsController < Admin::BaseController
  def index
    @coupons = Coupon.all
  end
end