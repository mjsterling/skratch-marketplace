class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @trade = Trade.find_by(@review.trade_id)
    @trade.reviewed = true

    if @review.save! && trade.update!
      flash[:notice] = 'Thank you for your review.'
    else
      flash[:alert] = 'Review not saved.'
    end
    redirect_to trades_path
  end

  protected
  def review_params
    params.require(:review).permit(:trade_id, :seller_id, :rating)
  end
end
