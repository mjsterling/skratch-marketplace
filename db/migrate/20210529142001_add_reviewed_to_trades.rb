class AddReviewedToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :reviewed, :boolean
  end
end
