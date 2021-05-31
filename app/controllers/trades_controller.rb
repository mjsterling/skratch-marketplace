class TradesController < ApplicationController

    def index
        # trades that have not been marked delivered by seller
        @sales = Trade.where seller_id: current_user.id, seller_confirmed: false
        @sales = "No active sales" if @sales.empty?

        # trades that are not marked delivered and/or not reviewed
        @purchases = current_user.trades.where reviewed: false
        @purchases = "No active purchases" if @purchases.empty?
    end

    def new
        @service = Service.find(params[:service_id])
        if @service.user == current_user
            flash[:alert] = 'You cannot purchase your own service.'
            redirect_to root_path and return 
        end

        @trade = Trade.new(service_id: @service.id)
    end

    def create
        @trade = Trade.new(trade_params)
        @trade.service = Service.find(@trade.service_id)
        flash[:alert] = "Insufficient balance." and redirect_to coins_path and return if current_user.balance.balance < @trade.service.price

        @trade.user = current_user
        @trade.user_confirmed = false
        @trade.seller_confirmed = false
        @trade.reviewed = false
        @trade.seller_id = @trade.service.user_id
        if @trade.save!
            price = @trade.service.price.to_i
            values = [current_user.balance.balance, @trade.seller.balance.balance]
            pp values
            current_user.balance.balance -= price
            @trade.service.user.balance.balance += price
            p current_user.balance.balance
            begin
                @trade.service.user.balance.save!
                current_user.balance.save!
            rescue
                flash[:alert] = 'Purchase unsuccessful: something went wrong. Please try again.'
                current_user.trades.last.destroy!
            else
                flash[:notice] = 'Service purchased successfully. Please check your email for further details.'
            end
            redirect_to profile_services_path
        else    
            flash[:alert] = 'Purchase unsuccessful: something went wrong. Please try again.'
            render :new
        end
    end

    def update
        @trade = Trade.find(params[:id])
        authorize_user!(@trade) if params[:user_confirmed]
        authorize_seller!(@trade) if params[:seller_confirmed]

        if @trade.update(trade_params)
          flash[:notice] = 'Delivery confirmed.'   
          redirect_to trades_path
        else
          flash[:alert] = 'Failed to update trade.'
          render :index
        end
    end

    def archived
        @sales = current_user.services.trades.where seller_confirmed: true
        @purchases = current_user.trades.where reviewed: true
    end

    protected

    def trade_params
        params.require(:trade).permit(:user_id, :service_id, :user_confirmed, :seller_confirmed, :reviewed)
    end

    def authorize_seller!(trade)
        redirect_to root_path and return unless current_user == trade.seller
    end
end
