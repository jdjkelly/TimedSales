class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :product
      t.string :variant
      t.datetime :start
      t.datetime :end
      t.decimal :price
      t.references :shop

      t.timestamps
    end
    add_index :sales, :shop_id
  end
end
