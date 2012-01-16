class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :api_url
      t.string :name

      t.timestamps
    end
  end
end
