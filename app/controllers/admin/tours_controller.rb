class Admin::ToursController < ApplicationController
  
  def new
    @category = Category.find(params[:category_id])
    @tour = Tour.new
  end

  def create
  end

end