class ServicesController < ApplicationController
    attr_accessor :services
    def initialize
        @services = Service.all
    end
    def index
        if params[:keywords]
            @services = Service.where("keywords LIKE ?", "%#{params[:keywords]}%" )
        elsif params[:category]
            @services = Service.where(category: params[:category])
        else 
            @services = Service.all
        end
    end
end
