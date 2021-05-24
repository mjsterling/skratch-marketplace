class ServicesController < ApplicationController
    def index
        @services = Services.where()
    end
end
