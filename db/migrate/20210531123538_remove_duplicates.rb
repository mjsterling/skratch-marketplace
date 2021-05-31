class RemoveDuplicates < ActiveRecord::Migration[6.1]
  def change
    remove_column :trades, :user_id
    remove_column :reviews, :user_id
    remove_column :reviews, :seller_id
  end
end
