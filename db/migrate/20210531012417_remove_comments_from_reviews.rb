class RemoveCommentsFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :comments
  end
end
