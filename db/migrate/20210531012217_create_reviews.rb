class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :trade_id
      t.integer :rating
      t.string :comments

      t.timestamps
    end
  end
end
