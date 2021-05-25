class CreateAvatars < ActiveRecord::Migration[6.1]
  def change
    create_table :avatars do |t|
      t.string :avatar
      t.timestamps
    end
    remove_column :users, :avatar
  end
end
