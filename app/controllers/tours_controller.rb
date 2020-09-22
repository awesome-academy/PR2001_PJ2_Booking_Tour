class ToursController < ApplicationController
  def show
    @tour = Tour.find(params[:id])
    @images = @tour.images
    @tour_details = @tour.tour_details
    @coupons = Coupon.get_coupon_for_user(current_user.id).or(Coupon.get_coupon_for_all) if current_user
  end

  def index
    @category = Category.find(params[:category_id])
    @tours = @category.tours
  end
end