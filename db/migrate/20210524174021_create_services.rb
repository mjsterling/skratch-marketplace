class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.integer :category
      t.integer :subcategory
      t.string :name
      t.text :description
      t.text :keywords

      t.timestamps
    end
  end
end
