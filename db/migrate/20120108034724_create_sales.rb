class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :product
      t.string :variant
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.money :price
      t.references :shop

      t.timestamps
    end
  end
end
