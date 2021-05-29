class FixTrades < ActiveRecord::Migration[6.1]
  def change
    drop_table :trades

    create_table :trades do |t|
      t.integer :user_id
      t.integer :seller_id
      t.integer :service_id

      t.timestamps
    end
  end
end
