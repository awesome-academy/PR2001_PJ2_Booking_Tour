class Users::SessionsController < Devise::SessionsController
  before_action :save_url, only: :new

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  private

  def save_url
    session[:forwarding_url] = params[:previous_url] if params[:previous_url].present?
  end
end