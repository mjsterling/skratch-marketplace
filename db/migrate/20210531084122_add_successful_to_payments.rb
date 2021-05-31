class AddSuccessfulToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :successful, :boolean
  end
end
