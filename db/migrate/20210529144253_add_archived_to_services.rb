class AddArchivedToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :archived, :boolean
  end
end
