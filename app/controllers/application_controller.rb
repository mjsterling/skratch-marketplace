require 'avatar' from 

class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def initialize
        @default_avatar = 
    end
end
