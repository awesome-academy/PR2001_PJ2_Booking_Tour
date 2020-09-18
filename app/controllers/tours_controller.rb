class ToursController < ApplicationController
  def show
    @tour = Tour.find(params[:id])
    @images = @tour.images
    @tour_details = @tour.tour_details
  end

  def index
    @category = Category.find(params[:category_id])
    @tours = @category.tours
  end
end