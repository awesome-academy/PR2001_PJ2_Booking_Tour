class RatingsController < ApplicationController
  def create
    @tour = Tour.find(params[:tour_id])
    @rating = current_user.ratings.build(tour_id: params[:tour_id], rate: params[:rate])
    @rating.save
  end
end