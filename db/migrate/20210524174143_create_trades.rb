class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.integer :status
      t.integer :req_amount
      t.float :req_hours
      t.integer :offer_amount
      t.float :offer_hours
      t.text :contract1
      t.text :contract2

      t.timestamps
    end
  end
end
