class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.save
    redirect_to '/cart_items'
  end

  private
  def cart_item_params
    params.permit(:item_id, :amount)
  end

end
