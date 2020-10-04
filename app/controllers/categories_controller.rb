class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @tours = @category.tours
  end

  def index
    @categories = Category.all
  end
end