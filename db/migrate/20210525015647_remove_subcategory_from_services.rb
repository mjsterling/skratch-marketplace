class RemoveSubcategoryFromServices < ActiveRecord::Migration[6.1]
  def change
    remove_column :services, :subcategory
    remove_column :services, :category
    add_column :services, :category, :string
  end
end
