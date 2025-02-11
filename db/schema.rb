# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_11_140921) do
  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity", default: 1, null: false
    t.decimal "price_snapshot", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id", "product_id"], name: "index_cart_items_on_cart_id_and_product_id", unique: true
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
    t.check_constraint "quantity > 0", name: "quantity_positive"
  end

  create_table "carts", force: :cascade do |t|
    t.decimal "discount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_carts_on_status"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.text "description"
    t.boolean "available", default: true, null: false
    t.string "sku", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available"], name: "index_products_on_available"
    t.index ["sku"], name: "index_products_on_sku", unique: true
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
end
