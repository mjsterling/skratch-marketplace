class ResetServices < ActiveRecord::Migration[6.1]
  def change
    drop_table :services
    
    create_table "services", force: :cascade do |t|
      t.string "name"
      t.string "description"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "category"
      t.integer "user_id"
      t.string "region"
      t.integer "price"
    end
  end
end
