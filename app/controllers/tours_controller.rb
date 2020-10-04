class ToursController < ApplicationController
  def show
    @tour = Tour.find(params[:id])
    @category = @tour.category
    @images = @category.images
    @tour_details = @tour.tour_details
    @booking_tour = BookingTour.new
  
    if current_user
      @coupons_get = Coupon.get_coupon_for_user(current_user.id).or(Coupon.get_coupon_for_all)
      @coupons = @coupons_get&.reject{|coupon| coupon.coupon_use_count == CouponUser.where(coupon_id: coupon.id)&.count}
    end
  end

  def index
    @category = Category.find(params[:category_id])
    @tours = @category.tours
  end
end