class HomeController < ApplicationController
    def payment_history
        # find and list successful payments
        @payments = current_user.payments.where successful: true
    end

    def profile_services
        @services = current_user.services.where(archived: false) 
    end
end
