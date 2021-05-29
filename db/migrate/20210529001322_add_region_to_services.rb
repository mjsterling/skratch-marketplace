class AddRegionToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :region, :string
  end
end
