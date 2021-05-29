class HomeController < ApplicationController
    attr_accessor :categories, :add_services_path
    def profile_services
        @services = Service.where(user_id: current_user.id)
    end

    def profile
        @add_services_path = add_services_path
        @balance_check = Balance.find_by(user_id: current_user.id)
        @balance = @balance_check.balance
    end
    
    def add_services_path
        return profile_services_path if current_user.first_name && current_user.region

        flash[:alert] = 'Please complete your profile before using Skratch.'
        edit_user_registration_path
    end
end
