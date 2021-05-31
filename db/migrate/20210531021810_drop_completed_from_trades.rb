class DropCompletedFromTrades < ActiveRecord::Migration[6.1]
  def change
    remove_column :trades, :completed
  end
end
