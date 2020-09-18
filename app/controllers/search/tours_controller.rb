class Search::ToursController < ApplicationController
  def index   
    @q = Tour.ransack(params[:q])
    @tours = @q.result
  end
end