class CartItemsController < ApplicationController
  include CartFinder

  before_action :set_cart_item, only: [ :destroy ]

  def create
    @cart_item = cart_manager.add_item(
      cart_item_params[:product_id],
      cart_item_params[:quantity]
    )
    respond_to do |format|
      format.turbo_stream { render_cart_item_update }
    end
  end

  def update
    @cart_item = cart_manager.update_item_quantity(
      params[:id],
      cart_item_params[:quantity]
    )
    respond_to do |format|
      format.turbo_stream { render_cart_item_update }
    end
  end

  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.turbo_stream { render_cart_item_removal }
    end
  end

  private

  def cart_manager
    @cart_manager ||= CartManager.new(@cart)
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end

  def render_cart_item_update
    render turbo_stream: [
      turbo_stream.replace(
        @cart_item,
        partial: "cart_items/cart_item",
        locals: { cart_item: @cart_item }
      ),
      turbo_stream.update(
        "cart-total",
        partial: "carts/total",
        locals: { cart: @cart }
      )
    ]
  end

  def render_cart_item_removal
    streams = [
      turbo_stream.remove(@cart_item),
      turbo_stream.update(
        "cart-total",
        partial: "carts/total",
        locals: { cart: @cart }
      )
    ]

    # Add empty state update if cart is empty
    if @cart.empty?
      streams << turbo_stream.update(
        "cart-empty-state",
        partial: "carts/empty_state",
        locals: { cart: @cart }
      )
    end

    render turbo_stream: streams
  end
end
