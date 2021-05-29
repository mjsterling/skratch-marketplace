class RemoveKeywordsFromServices < ActiveRecord::Migration[6.1]
  def change
    remove_column :services, :keywords
  end
end
