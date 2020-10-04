class Admin::ToursController < Admin::BaseController
  layout "admin"
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new(tour_params)
    ActiveRecord::Base.transaction do
      @tour.save!
      CreateHotelTour.new(params[:tour][:hotel], @tour).perform
    end
    flash[:success] = 'Tour created!'
    redirect_to admin_tour_url(@tour)
  rescue StandardError
    flash.now[:danger] = "Creating is failed!"
    render 'new'
  end

  def show
    @tour_details = @tour.tour_details
    @tour_detail = TourDetail.new
  end

  def edit
  end

  def update    
    ActiveRecord::Base.transaction do
      @tour.update!(tour_params)
      HotelTour.where(tour_id: @tour.id).destroy_all        
      CreateHotelTour.new(params[:tour][:hotel], @tour).perform
    end
    flash[:success] = 'Tour updated!'
    redirect_to admin_tour_url(@tour)
  rescue StandardError
    flash.now[:danger] = "updating is failed!"
    render 'edit'
  end

  def index
    @tours = Tour.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @tour.destroy
    flash[:success] = 'Tour deleted!'
    redirect_to admin_tours_url
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :category_id, :itinerary, :transport,
                                 :food_and_drink, :price_info,:price, :coupon,
                                 :seats)
  end

  def set_tour
    @tour = Tour.find(params[:id])
  end
end