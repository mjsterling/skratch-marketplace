class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :amount

      t.timestamps
    end
  end
end
