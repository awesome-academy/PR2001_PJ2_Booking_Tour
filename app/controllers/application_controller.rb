class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  
  def after_sign_in_path_for resource
    referer_path = stored_location_for resource
    if referer_path.present? && referer_path != root_path
      referer_path
    else
      root_path
    end
  end

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
