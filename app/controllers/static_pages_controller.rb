class StaticPagesController < ApplicationController
  def home
    @q = Tour.ransack(params[:q])
    @categories = Category.all
  end
end
