class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:sunname, :name, :sunname_kana, :name_kana, :postal_code, :address, :telephone_number])
  end
end
