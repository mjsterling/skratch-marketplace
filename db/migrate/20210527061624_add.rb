class Add < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar, :string

    drop_table :avatars
  end
end
