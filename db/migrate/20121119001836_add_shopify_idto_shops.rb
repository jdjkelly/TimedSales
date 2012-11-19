class AddShopifyIdtoShops < ActiveRecord::Migration
  def change
    add_column :shops, :shopify_id, :int
  end
end