class AddSellerIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :seller_id, :integer
  end
end
