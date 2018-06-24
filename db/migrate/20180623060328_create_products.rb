class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :sku
      t.string :description
      t.string :manufacturer

      t.timestamps
    end
  end
end
