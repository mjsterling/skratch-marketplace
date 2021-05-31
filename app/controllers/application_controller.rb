require_relative "concerns/lists"

class ApplicationController < ActionController::Base
    attr_reader :regions, :categories
    before_action :authenticate_user!

    def initialize
        super
        @lists = Lists.new
    end
    
    def authorize_user!(model)
        return if model.user_id == current_user.id

        flash[:alert] = 'You do not have permission to access that page.'
        redirect_to root_path and return
    end

    def seller
        User.find(id: self.seller_id)
    end
end
