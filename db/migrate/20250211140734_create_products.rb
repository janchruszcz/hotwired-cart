class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :description
      t.boolean :available, default: true, null: false
      t.string :sku, null: false

      t.timestamps
    end

    add_index :products, :sku, unique: true
    add_index :products, :available
  end
end
