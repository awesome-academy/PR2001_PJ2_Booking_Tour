class Admin::ToursController < Admin::BaseController

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new(tour_params)
    if @tour.save
      params[:images]['link'].each do |a|
        @image = @tour.images.create!(:link => a)
      end  
      flash[:success] = 'Tour created!'
      redirect_to admin_tour_url(@tour)
    else
      render 'new'
    end  
  end

  def show
    @tour = Tour.find(params[:id])
  end

  def edit
  end

  def index
    @tours = Tour.all
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :category_id, :description, :price, :coupon,
                                 :seats, images_attributes: [:id, :tour_id, :link])
  end
end