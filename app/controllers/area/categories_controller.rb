class Area::CategoriesController < ApplicationController
  def index
    @categories = Category.where(area: params[:area])
  end
end
