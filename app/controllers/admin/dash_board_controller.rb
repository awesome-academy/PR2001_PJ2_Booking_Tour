class Admin::DashBoardController < Admin::BaseController
  layout "admin"
  def home
    @tour = Tour.all
  end
end
