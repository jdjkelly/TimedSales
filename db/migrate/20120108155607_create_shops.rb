class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.string :url

      t.timestamps
    end
  end
end
