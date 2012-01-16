class AddCompareToToSale < ActiveRecord::Migration
  def change
  	add_column :sales, :compare_at, :decimal
  end
end
