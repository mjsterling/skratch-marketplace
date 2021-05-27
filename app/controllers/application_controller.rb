require_relative "../../lib/poros/lists"

class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    attr_reader :lists

    def initialize
        @lists = Lists.new
    end
end
