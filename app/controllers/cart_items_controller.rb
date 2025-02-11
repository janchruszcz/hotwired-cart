class CartItemsController < ApplicationController
  before_action :set_cart
  before_action :set_cart_item, only: [ :update, :destroy ]

  def create
    @cart_item = @cart.cart_items.build(cart_item_params)

    if @cart_item.save
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def update
    @cart_item.update(cart_item_params)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
