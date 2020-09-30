class RatesController < ApplicationController
  def create

    @tour = Tour.find(params[:tour_id])
    @rate = current_user.rates.build(rate_params)
    @rate.tour = @tour
    if @rate.save
      redirect_to category_tour_url(@tour.category, @tour)
    else
      @images = @tour.images
      @tour_details = @tour.tour_details
      flash[:danger] = "Please rate again!"
      render 'tours/show'
    end
  end


  private

  def rate_params
    params.require(:rate).permit(:value)
  end
end