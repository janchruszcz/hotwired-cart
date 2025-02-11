require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cart = carts(:cart_with_items)
    post set_cart_path(@cart)
  end

  test "shows cart" do
    get cart_path
    assert_response :success
  end

  test "updates cart discount" do
    patch cart_path, params: {
      cart: { discount: 5 }
    }, as: :turbo_stream

    assert_response :success
    assert_equal 5, Cart.find(@cart.id).discount
  end

  test "clears cart" do
    assert_difference("CartItem.count", -@cart.cart_items.count) do
      delete cart_path
    end
    assert_redirected_to cart_path
  end
end
