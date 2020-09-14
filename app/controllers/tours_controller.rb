class ToursController < ApplicationController
  def show
    @tour = Tour.find(params[:id])
    @images = @tour.images
    @tour_details = @tour.tour_details
  end
end