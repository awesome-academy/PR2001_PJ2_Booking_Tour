class BookingToursController < ApplicationController
  before_action :set_tour
  before_action :set_booking_tour, only: [:show, :edit, :update]

  def new
    @booking_tour = BookingTour.new
    @tour_detail = TourDetail.find(params[:tour_detail_id])
  end

  def create
    @booking_tour = current_user.booking_tours.build(booking_tour_params)
    @booking_tour.price = @tour.price
    @booking_tour.coupon = @tour.coupon
    @booking_tour.price_total = params[:booking_tour][:quantity].to_i *
                                  @tour.price * (1 - @tour.coupon / 100.to_f)
    if @booking_tour.save
      flash[:success] = "Booking success! Thank you for your booking!"
      redirect_to tour_booking_tour_path(@tour, @booking_tour)
    else
      @tour_detail = TourDetail.find(params[:booking_tour][:tour_detail_id])
      flash.now[:danger] = 'Your booking is failed!'
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
    @booking_tour.price = @tour.price
    @booking_tour.coupon = @tour.coupon
    @booking_tour.price_total = params[:booking_tour][:quantity].to_i *
                                  @tour.price * (1 - @tour.coupon / 100.to_f)
    if @booking_tour.update(booking_tour_params)
      flash[:success] = "Update success! Thank you for your booking!"
      redirect_to tour_booking_tour_path(@tour, @booking_tour)
    else
      @tour_detail = @booking_tour.tour_detail
      flash.now[:danger] = 'Your update is failed!'
      render 'edit'
    end
  end

  private

  def booking_tour_params
    params.require(:booking_tour).permit(:tour_detail_id, :quantity, :price_total)
  end

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end

  def set_booking_tour
    @booking_tour = BookingTour.find(params[:id])
  end
end