class HomeController < ApplicationController
    def profile_services
        @services = Service.where(user_id: current_user.id)
    end

    def payment_history
        @payments = current_user.payments.where(successful: true)
    end
end
