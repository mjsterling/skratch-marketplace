class AddRatingToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :rating, :float
  end
end
