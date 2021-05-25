class HomeController < ApplicationController
    def index
        @constants = Constants.new
        render layout: 'application'
    end
end
