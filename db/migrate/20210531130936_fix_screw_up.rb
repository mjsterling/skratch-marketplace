class FixScrewUp < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :user_id, :integer
    remove_column :trades, :seller_id
  end
end
