class AddCompletedToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :completed, :boolean
    remove_column :trades, :archived
  end
end
