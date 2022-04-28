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
  end

  def create
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    #1. 確認画面から送られてきた、配送先・支払い方法を取得
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
    if params[:order][:payment_method] == "0"
      @order.payment_method = credit_card
    elsif params[:order][:payment_method] =="1"
      @order.payment_method = transfer
    end
    #2. カート内の合計金額から請求金額を算出
    sum = 0
		@cart_items.each do |cart_item|
			sum += (cart_item.item.price_without_tax * 1.1).floor * cart_item.quantity
		end
		session[:order][:postage] = 800
		session[:order][:total_payment] = sum + session[:order][:postage]
    #3.注文(Order)モデルに注文を保存
    @order.save
    #4.注文詳細(OrderDetail)モデルにカート内商品の情報をもとに保存
    current_member.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @order_detail = OrderDetail.new #初期化宣言
      @order_detail.item_id = cart_item.item_id #商品idを注文商品idに代入
      @order_detail.quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
      @order_detail.tax_included_price = (cart_item.item.price*1.1).floor #消費税込みに計算して代入
      @order_detail.order_id =  @order.id #注文商品に注文idを紐付け
      @order_detail.save #注文商品を保存
    end #ループ終わり
    #5.注文者のカート内商品を全て削除
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
    params.require(:order).permit(:customer_id, :postage, :total_payment, :payment_method, :name, :address, :postal_code, :status)
   end


end
