class CartsController < ApplicationController
  include CartFinder

  def show
    @cart_presenter = CartPresenter.new(@cart)
  end

  def update
    cart_manager.apply_discount(params[:cart][:discount])
    respond_to do |format|
      format.turbo_stream { render_cart_update }
    end
  end

  def destroy
    cart_manager.clear
    redirect_to cart_path, notice: t(".success")
  end

  def checkout
    if cart_manager.checkout
      redirect_to root_path, notice: t(".success")
    else
      redirect_to cart_path, alert: t(".failure")
    end
  end

  private

  def cart_manager
    @cart_manager ||= CartManager.new(@cart)
  end

  def render_cart_update
    render turbo_stream: [
      turbo_stream.update("cart-total",
        partial: "carts/total",
        locals: { cart: @cart })
    ]
  end
end
