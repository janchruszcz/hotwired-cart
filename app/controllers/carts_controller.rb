class CartsController < ApplicationController
  before_action :set_cart

  def show
  end

  def update
    @cart.update(cart_params)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Cart has been cleared"
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end

  def cart_params
    params.require(:cart).permit(:discount)
  end
end
