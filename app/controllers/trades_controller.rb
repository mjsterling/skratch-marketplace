class TradesController < ApplicationController

    def index
        @trades = Trade.where(seller_id: current_user.id)
        @sales = @trades.map { |trade| trade_hash_from_AR(trade, "seller") }
        @sales = 'No sales recorded yet' if @sales.empty?

        @trades = Trade.where(user_id: current_user.id)
        @purchases = @trades.map { |trade| trade_hash_from_AR(trade, "buyer") }
        @purchases = 'No purchases recorded yet' if @purchases.empty?
    end

    def new
        @user_balance = Balance.find_by(user_id: current_user.id)
        @user_balance = @user_balance.balance
        @name = params[:name]
        @description = params[:description]
        @trade = Trade.new
        @trade[:seller_id] = params[:seller_id]
        @trade[:service_id] = params[:service_id]
        @trade[:price] = params[:price]
    end

    def create
        @trade = Trade.new(trade_params)
        @balance = Balance.find_by(user_id: current_user.id)
        @abort = false
        unless @balance.balance.to_i >= @trade.price.to_i
            flash[:alert] = 'Insufficient balance to purchase this service. Please purchase more SkratchCoins.'
            @abort = true
            redirect_to profile_path
        end

        return if @abort
        @trade.user = current_user
        if @trade.save
            update_balances(@trade.id, @trade.seller_id, @trade.price)
            flash[:notice] = 'Service purchased successfully. Please check your email for further details.'
            redirect_to profile_path
        else
            flash[:alert] = 'Transaction unsuccessful. Please contact support.'
            render :new
        end
    end

    protected

    def trade_params
        params.require(:trade).permit(:seller_id, :service_id, :price)
    end

    def update_balances(trade, seller, price)
        @buyer_balance = Balance.find_by(user_id: current_user.id)
        @seller_balance = Balance.find_by(user_id: seller)
        @buyer_balance.balance -= price
        @seller_balance.balance += price
        begin
          @buyer_balance.save
          @seller_balance.save
        rescue
          raise ActiveRecord::Rollback
          flash[:alert] = 'Purchase unsuccessful: something went wrong. Please try again.'
          redirect_to profile_path
        end
    end

    def trade_hash_from_AR(trade, type)
        service = Service.find_by(id: trade[:service_id])
        id = type == "seller" ? trade[:user_id] : trade[:seller_id]
        puts "id #{id} type #{type}"
        other_user = User.find_by(id: id)

        { 
          created_at: trade.created_at,
          price: trade.price,
          name: service.name,
          email: other_user.email
        }
    end
end
