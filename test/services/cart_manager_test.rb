require "test_helper"

class CartManagerTest < ActiveSupport::TestCase
  def setup
    @cart = carts(:empty_cart)
    @product = products(:speaker)
    @manager = CartManager.new(@cart)
  end

  test "adds new item to cart" do
    assert_difference -> { @cart.cart_items.count } do
      @manager.add_item(@product.id)
    end
  end

  test "increases quantity of existing item" do
    item = @manager.add_item(@product.id)
    assert_no_difference -> { @cart.cart_items.count } do
      @manager.add_item(@product.id)
    end
    assert_equal 2, item.reload.quantity
  end

  test "updates item quantity" do
    item = @manager.add_item(@product.id)
    @manager.update_item_quantity(item.id, 3)
    assert_equal 3, item.reload.quantity
  end

  test "removes item when quantity is zero" do
    item = @manager.add_item(@product.id)
    assert_difference -> { @cart.cart_items.count }, -1 do
      @manager.update_item_quantity(item.id, 0)
    end
  end

  test "applies discount" do
    @manager.apply_discount(50)
    assert_equal 50, @cart.reload.discount
  end

  test "caps discount at maximum" do
    @manager.apply_discount(150)
    assert_equal 100, @cart.reload.discount
  end
end
