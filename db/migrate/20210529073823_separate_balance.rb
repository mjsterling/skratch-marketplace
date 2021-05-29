class SeparateBalance < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :balance
    create_table :balances do |t|
      t.integer :user_id
      t.integer :balance
      t.timestamps
    end
  end
end
