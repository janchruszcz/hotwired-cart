class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.decimal :discount, precision: 10, scale: 2, default: 0.0, null: false
      t.string :status, default: 'active', null: false

      t.timestamps
    end

    add_index :carts, :status
  end
end
