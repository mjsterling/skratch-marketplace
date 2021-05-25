class HomeController < ApplicationController
    attr_reader :constants
    def index
        @constants = Constants.new
    end
end
