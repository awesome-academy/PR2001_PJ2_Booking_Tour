class Admin::HotelsController < Admin::BaseController
  layout "admin"
  before_action :set_hotel, except: [:new, :index, :create]

  def index
    @hotels = Hotel.all
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      flash[:success] = "Create success!"
      redirect_to admin_hotel_path(@hotel)
    else
      flash.now[:danger] = "Create failed!"
      render "new"
    end
  end

  def show
    @images = @hotel.images
  end

  def edit
  end

  def update
    if @hotel.update(hotel_params)
      flash[:success] = "Update success!"
      redirect_to admin_hotel_path(@hotel)
    else
      flash.now[:danger] = "Update failed!"
      render "edit"
    end
  end

  def destroy
    @hotel.destroy
    flash[:success] = "Delete success!"
    redirect_to admin_hotels_path
  end

  private
  def hotel_params
    params.require(:hotel).permit(:name, :overview, :link, :location, images_attributes: [:id, :link])
  end

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end
end