class RemoveTitleFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :title
  end
end
