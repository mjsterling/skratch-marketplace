class AddQuantityToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :quantity, :integer
  end
end
