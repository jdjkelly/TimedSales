class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.text :description
      t.string :product_id
      t.references :shop

      t.timestamps
    end
  end
end
