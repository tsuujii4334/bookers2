class ApplicationController < ActionController::Base
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,:sign_in, keys: [:name])
  end

end
