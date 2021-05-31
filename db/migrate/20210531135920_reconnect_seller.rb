class ReconnectSeller < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :seller_id, :integer
  end
end
