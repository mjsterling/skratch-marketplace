class AddForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_column :avatars, :user_id, :integer

    add_column :reviews, :user_id, :integer
    add_column :reviews, :target_id, :integer
    add_column :reviews, :service_id, :integer
    
    add_column :services, :user_id, :integer
    add_column :trades, :user_id, :integer
    add_column :trades, :target_id, :integer
    add_column :trades, :user_service_id, :integer
    add_column :trades, :target_service_id, :integer
    rename_column :trades, :req_amount, :target_amount
    rename_column :trades, :req_hours, :target_hours
    rename_column :trades, :offer_amount, :user_amount
    rename_column :trades, :offer_hours, :user_hours
  end
end
