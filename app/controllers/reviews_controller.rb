class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    trade = Trade.find(@review.trade_id)
    trade.reviewed = true

    if @review.save! && trade.save!
      flash[:notice] = 'Thank you for your review.'

      seller_reviews = Review.where(seller_id: @review.seller_id)
      if seller_reviews.length >= 5
        seller = User.find(@review.seller_id)
        seller.rating = (seller_reviews.map{|r| r.rating}.sum / seller_reviews.length).round(2)
        seller.save
      end
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
