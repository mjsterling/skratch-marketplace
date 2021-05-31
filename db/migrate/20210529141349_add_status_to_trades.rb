class AddStatusToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :user_confirmed, :boolean
    add_column :trades, :seller_confirmed, :boolean
    add_column :trades, :archived, :boolean
  end
end
