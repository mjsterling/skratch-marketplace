class AddServiceIdToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :service_id, :integer
  end
end
