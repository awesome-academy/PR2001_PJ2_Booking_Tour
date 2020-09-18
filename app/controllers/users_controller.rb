class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @booking_tours = @user.booking_tours
  end
end