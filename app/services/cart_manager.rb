# app/services/cart_manager.rb
class CartManager
  def initialize(cart)
    @cart = cart
  end

  def add_item(product_id, quantity = 1)
    item = @cart.cart_items.find_or_initialize_by(product_id: product_id)
    item.quantity = item.new_record? ? quantity : item.quantity + quantity
    item.save
    item
  end

  def update_item_quantity(item_id, quantity)
    item = @cart.cart_items.find(item_id)
    quantity.to_i <= 0 ? item.destroy : item.update(quantity: quantity)
    item
  end

  def apply_discount(amount)
    @cart.update(discount: [ amount.to_f, 100 ].min)
  end

  def clear
    @cart.cart_items.destroy_all
  end

  def checkout
    return false unless @cart.valid_for_checkout?

    ActiveRecord::Base.transaction do
      # Here you could add order creation, payment processing, etc.
      clear
      true
    end
  end
end
