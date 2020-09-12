class Admin::TourDetailsController < Admin::BaseController
  def create
    @tour = Tour.find(params[:tour_id])
    @tour_detail = @tour.tour_details.build(tour_detail_params)
    if @tour_detail.save
      flash[:success] = 'Time created!'
      redirect_to admin_tour_url(@tour)
    else
      @tour_details = @tour.tour_details.reject{ |a| a.id == nil }
      @images = @tour.images
      flash.now[:danger] = 'Setting fail!'
      render "admin/tours/show"
    end
  end

  def edit
    @tour_detail = TourDetail.find(params[:id])
    @tour = @tour_detail.tour
    @tour_details = @tour.tour_details
    @images = @tour.images
    render "admin/tours/show"
  end

  def update
    @tour_detail = TourDetail.find(params[:id])
    @tour = @tour_detail.tour
    if @tour_detail.update(tour_detail_params)
      flash[:success] = 'Time updated!'
      redirect_to admin_tour_url(@tour)
    else
      @tour_details = @tour.tour_details
      @images = @tour.images
      flash.now[:danger] = 'Update fail!'
      render "admin/tours/show"
    end
  end

  def destroy
    @tour_detail = TourDetail.find(params[:id])
    @tour_detail.destroy
    flash[:success] = 'Time deleted!'
    redirect_to admin_tour_url(@tour_detail.tour)
  end

  private

  def tour_detail_params
    params.require(:tour_detail).permit(:departure_time, :return_time)
  end

  def set_tour_detail
    @tour_detail = TourDetail.find(params[:id])
  end

end