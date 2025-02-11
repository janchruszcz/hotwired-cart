require "application_system_test_case"

class CartFlowsTest < ApplicationSystemTestCase
  def setup
    @product = products(:speaker)
    @cart = carts(:empty_cart)
  end

  test "adding product to cart" do
    visit root_path

    click_on "Add to Cart"

    assert_selector "#cart-items" do
      assert_text @product.name
      assert_text number_to_currency(@product.price)
    end
  end

  test "updating item quantity" do
    visit cart_path

    within "#cart_item_#{cart_items(:speaker_item).id}" do
      click_on "+"
      assert_text "2"
      assert_text number_to_currency(@product.price * 2)
    end
  end

  test "removing item from cart" do
    visit cart_path

    accept_confirm do
      click_on "Remove"
    end

    assert_text "The cart is empty"
  end

  test "applying discount" do
    visit cart_path

    find("#cart_discount").set(50)

    assert_text "-#{number_to_currency(50)}"
  end

  test "checking out" do
    visit cart_path

    accept_confirm do
      click_on "Place order"
    end

    assert_text "The cart is empty"
  end
end
