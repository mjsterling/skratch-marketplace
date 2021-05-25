require_relative "../../lib/poros/constants"

class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |prms|
            prms.permit(:email, :password)
        end

        devise_parameter_sanitizer.permit(:account_update) do |prms|
            prms.permit(:email, :password, :current_password, :first_name, :last_name, :title, :avatar)
        end
    end
end
