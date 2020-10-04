class StaticPagesController < ApplicationController
  def home
    @q = Tour.ransack(params[:q])
    @categories = Category.all
    @tours = Tour.all
  end
end
