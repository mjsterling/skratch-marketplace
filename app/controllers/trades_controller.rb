class TradesController < ApplicationController

    def index
        # trades that have not been marked delivered by seller
        @sales = current_user.services.trades.where seller_confirmed: false

        # trades that are not marked delivered and/or not reviewed
        @purchases = current_user.trades.where user_confirmed: false
    end

    def new
        @service = Service.find(params[:service_id])
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
        if @trade.save!
            update_balances(@trade)
        else    
            flash[:alert] = 'Transaction unsuccessful. Please contact support.'
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

    def update_balances(trade)
        current_user.balance.balance -= trade.service.price
        trade.seller.balance.balance += trade.service.price
        begin
          current_user.balance.update!
          trade.seller.balance.update!
          flash[:notice] = 'Service purchased successfully. Please check your email for further details.'
        rescue
          flash[:alert] = 'Purchase unsuccessful: something went wrong. Please try again.'
          current_user.trades.last.destroy!
        end
        redirect_to profile_services_path
    end
end
