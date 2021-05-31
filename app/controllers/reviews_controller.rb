class ReviewsController < ApplicationController
  def create
    redirect_to trades_path and return unless params[:review][:rating]
    
    params[:review][:rating] = params[:review][:rating].scan(/[0-9]/).first.to_i
    @review = Review.new(review_params)
    @trade = Trade.find(@review.trade_id)
    @review.trade = @trade
    @review.seller_id = @trade.seller_id
    @trade.reviewed = true

    if @trade.save && @review.save
      flash[:notice] = 'Thank you for your review.'
    else
      flash[:alert] = 'Review unable to be saved.'
    end
    redirect_to trades_path
  end

  protected
  def review_params
    params.require(:review).permit(:trade_id, :rating)
  end
end
