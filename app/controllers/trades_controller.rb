class TradesController < ApplicationController

    def index
        @sales = Trade.where(seller_id: current_user.id, seller_confirmed: false)
        @purchases = Trade.where(user_id: current_user.id, reviewed: false )
    end

    def new
        @service = Service.find(params[:trade][:service_id])
        @name = params[:name]
        @description = params[:description]
        @trade = Trade.new(service_id: @service.id, )
    end

    def create
        @trade = Trade.new(trade_params)
        @trade.user = current_user
        if @user.balance.balance < @trade.price
            flash[:alert] = 'Insufficient balance to purchase this service. Please purchase more SkratchCoins.'
            redirect_to profile_coins_path
        end
        return if @abort

        @trade.user = current_user
        @trade.user_confirmed = false
        @trade.seller_confirmed = false
        @trade.reviewed = false
        @trade.archived = false
        if @trade.save!
            update_balances(@trade.id, @trade.seller_id, @trade.price)
            flash[:notice] = 'Service purchased successfully. Please check your email for further details.'
            redirect_to profile_path
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
        @sales = Trade.where(seller_id: current_user.id, seller_confirmed: true)
        @purchases = Trade.where(user_id: current_user.id, reviewed: true)
    end

    protected

    def trade_params
        params.require(:trade).permit(:user_id, :seller_id, :service_id, :price, :user_confirmed, :seller_confirmed, :reviewed)
    end

    def authorize_seller!(trade)
        redirect_to root_path and return unless trade.seller_id == current_user.id
    end

    def update_balances(trade, seller, price)
        @buyer_balance = Balance.find_by(user_id: current_user.id)
        @seller_balance = Balance.find_by(user_id: seller)
        @buyer_balance.balance -= price
        @seller_balance.balance += price
        begin
          @buyer_balance.save!
          @seller_balance.save!
        rescue
          raise ActiveRecord::Rollback
          flash[:alert] = 'Purchase unsuccessful: something went wrong. Please try again.'
          redirect_to profile_path
        end
    end
end
