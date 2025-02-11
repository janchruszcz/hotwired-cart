require "test_helper"

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cart = carts(:cart_with_items)
    post set_cart_path(@cart)  # Using post to set session
  end

  test "creates cart item" do
    assert_difference -> { CartItem.count } do
      post cart_items_path, params: {
        cart_item: { product_id: products(:speaker).id, quantity: 1 }
      }, as: :turbo_stream
    end
    assert_response :success
  end

  test "updates cart item quantity" do
    cart_item = cart_items(:speaker_item)
    patch cart_item_path(cart_item), params: {
      cart_item: { quantity: 2 }
    }, as: :turbo_stream

    assert_response :success
    cart_item.reload
    assert_equal 2, cart_item.quantity
  end

  test "removes cart item" do
    cart_item = cart_items(:speaker_item)

    assert_difference("CartItem.count", -1) do
      delete cart_item_path(cart_item), as: :turbo_stream
    end
    assert_response :success
  end
end
