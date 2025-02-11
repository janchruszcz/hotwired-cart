require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  def setup
    @cart_item = cart_items(:speaker_item)
  end

  test "requires positive quantity" do
    @cart_item.quantity = 0
    assert_not @cart_item.valid?
    assert_not_nil @cart_item.errors[:quantity]
  end

  test "calculates subtotal" do
    expected = @cart_item.price_snapshot * @cart_item.quantity
    assert_equal expected, @cart_item.subtotal
  end
end
