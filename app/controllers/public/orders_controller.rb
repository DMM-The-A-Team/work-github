class Public::OrdersController < ApplicationController
  #before_action :authenticate_member!

  def new #注文情報入力画面
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.sunname + current_customer.name
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:shipping_postal_code]
      @order.address = params[:order][:shipping_address]
      @order.name = params[:order][:shipping_name]
    end
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    @order.total_payment = 0
    @cart_items.each do |cart_item|
      @order.total_payment += cart_item.item.get_tax_include_price * cart_item.amount
    end
  end


  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
 end

  def about
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
    @order_details = @order.order_details
  end

  private
   def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :shipping_cost)

   end

end
