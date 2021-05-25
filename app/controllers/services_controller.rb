class ServicesController < ApplicationController
    attr_accessor :services
    def initialize
        @services = Service.all
    end
    def index
        @services = Service.where(category: params["format"])
        render layout: "application"
    end
end
