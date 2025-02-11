require "test_helper"

class CartTest < ActiveSupport::TestCase
  def setup
    @cart = carts(:cart_with_items)
  end

  test "calculates total price" do
    expected_total = @cart.cart_items.sum { |item| item.price_snapshot * item.quantity }
    assert_equal expected_total, @cart.total_price
  end

  test "applies discount correctly" do
    @cart.update(discount: 10)
    expected_total = @cart.total_price - 10

    assert_equal expected_total, @cart.discounted_total
  end

  test "prevents negative total after discount" do
    @cart.update(discount: 1000)
    assert_equal 0, @cart.discounted_total
  end

  test "validates discount range" do
    @cart.discount = 101
    assert_not @cart.valid?
    assert_not_nil @cart.errors[:discount]

    @cart.discount = -1
    assert_not @cart.valid?
    assert_not_nil @cart.errors[:discount]
  end
end
