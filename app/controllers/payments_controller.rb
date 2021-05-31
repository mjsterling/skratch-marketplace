class PaymentsController < ApplicationController
  def new
    @payment = Payment.new(amount: params[:amount].to_i * 100)
    @payment.user = current_user
    @payment.save!
  end

  def create
    @payment = current_user.payments.order("created_at DESC").first
    @amount = @payment.amount
    begin
      customer = Stripe::Customer.create(email: params[:stripeEmail], source: params[:stripeToken])
      charge = Stripe::Charge.create(customer: customer.id, amount: @amount,
                                     description: "#{@amount / 100} SkratchCoins", currency: 'aud')
      current_user.balance.balance += @amount / 100
      current_user.balance.save!
      @payment.successful = true
      @payment.save!
      flash[:notice] = 'Thank you for your purchase.'
      redirect_to profile_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
  end

end
