class BookingToursController < ApplicationController
  before_action :set_tour
  before_action :set_booking_tour, only: [:show, :edit]

  def new
    @booking_tour = BookingTour.new
    @tour_detail = TourDetail.find(params[:tour_detail_id])
    @coupons_get = Coupon.get_coupon_for_user(current_user.id).or(Coupon.get_coupon_for_all)
    @coupons = @coupons_get.reject{|coupon| coupon.coupon_use_count == CouponUser.where(coupon_id: coupon.id)&.count}
  end

  def create
    result = CreateBooking.new(@tour, current_user, booking_tour_params, params[:code], params[:id]).perform
    if result[:success]
      flash[:success] = result[:message]
      redirect_to tour_booking_tour_path(@tour, result[:data][:booking_tour])
    else
      if current_user
        @coupons_get = Coupon.get_coupon_for_user(current_user.id).or(Coupon.get_coupon_for_all)
        @coupons = @coupons_get&.reject{|coupon| coupon.coupon_use_count == CouponUser.where(coupon_id: coupon.id)&.count}
      end
      @tour_detail = TourDetail.find(params[:booking_tour][:tour_detail_id])
      @booking_tour = result[:data][:booking_tour] 
      flash.now[:danger] = result[:message]
      render 'new'
    end
  end

  def show
    @tour_detail = @booking_tour.tour_detail
  end

  def edit
    @tour_detail = @booking_tour.tour_detail
  end

  def update
    result = CreateBooking.new(@tour, current_user, booking_tour_params, params[:code], params[:id]).update
    if result[:success]
      flash[:success] = result[:message]
      redirect_to tour_booking_tour_path(@tour, result[:data][:booking_tour])
    else
      @category = @tour.category
      @images = @category.images
      if current_user
        @coupons_get = Coupon.get_coupon_for_user(current_user.id).or(Coupon.get_coupon_for_all)
        @coupons = @coupons_get&.reject{|coupon| coupon.coupon_use_count == CouponUser.where(coupon_id: coupon.id)&.count}
      end
      @tour_detail = TourDetail.find(params[:booking_tour][:tour_detail_id])
      @booking_tour = result[:data][:booking_tour] 
      flash.now[:danger] = result[:message]
      render 'edit'
    end
  end

  private

  def booking_tour_params
    params.require(:booking_tour).permit(:tour_detail_id, :quantity, :option)
  end

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end

  def set_booking_tour
    @booking_tour = BookingTour.find(params[:id])
  end
end
