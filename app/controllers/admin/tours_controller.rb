class Admin::ToursController < Admin::BaseController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new(tour_params)
    if @tour.save
      flash[:success] = 'Tour created!'
      redirect_to admin_tour_url(@tour)
    else
      render 'new'
    end  
  end

  def show
    @tour_details = @tour.tour_details
    @tour_detail = TourDetail.new
    @images = @tour.images
    @image = Image.new
  end

  def edit
  end

  def update
    if @tour.update(tour_params)
      flash[:success] = 'Tour updated!'
      redirect_to admin_tour_url(@tour)
    else
      render 'edit'
    end
  end

  def index
    @tours = Tour.all
  end

  def destroy
    @tour.destroy
    flash[:success] = 'Tour deleted!'
    redirect_to admin_tours_url
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :category_id, :description, :price, :coupon,
                                 :seats, images_attributes: [:id, :link])
  end

  def set_tour
    @tour = Tour.find(params[:id])
  end
end