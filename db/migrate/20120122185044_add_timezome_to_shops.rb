class AddTimezomeToShops < ActiveRecord::Migration
  def change
  	add_column :shops, :timezone, :string
  end
end
