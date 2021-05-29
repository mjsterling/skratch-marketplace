class AddTradesToPrice < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :price, :integer
  end
end
