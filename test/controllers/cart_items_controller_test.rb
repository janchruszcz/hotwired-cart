require "test_helper"

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cart = carts(:cart_with_items)
    post set_cart_path(@cart)  # Using post to set session
  end

  test "creates cart item for new product" do
    assert_difference -> { CartItem.count } do
      post cart_items_path, params: {
        cart_item: { product_id: products(:shoes).id, quantity: 1 }
      }, as: :turbo_stream
    end
    assert_response :success
  end

  test "updates quantity when adding existing product" do
    assert_no_difference -> { CartItem.count } do
      post cart_items_path, params: {
        cart_item: { product_id: products(:speaker).id, quantity: 1 }
      }, as: :turbo_stream
    end

    assert_response :success
    assert_equal 2, cart_items(:speaker_item).reload.quantity
  end

  test "removes cart item" do
    cart_item = cart_items(:speaker_item)

    assert_difference("CartItem.count", -1) do
      delete cart_item_path(cart_item), as: :turbo_stream
    end
    assert_response :success
  end
end
