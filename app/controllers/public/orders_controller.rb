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
    @customer = current_customer
    @order = Order.new(order_params)
    @order.customer_id = @customer.id
    @order.save
    # ordered_itmemの保存
    @customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @ordered_item = OrderedItem.new #初期化宣言
      @ordered_item.item_id = cart_item.item_id #商品idを注文商品idに代入
      @ordered_item.quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
      @ordered_item.tax_included_price = (cart_item.item.price*1.08).floor #消費税込みに計算して代入
      @ordered_item.order_id =  @order.id #注文商品に注文idを紐付け
      @ordered_item.save #注文商品を保存
    end #ループ終わり

    @customer.cart_items.destroy_all #カートの中身を削除
    redirect_to orders_complete_path
  end

  # 注文完了画面
  def about
  end

  # 注文情報履歴一覧
  def index
    @orders = current_customer.orders
  end

  # 注文情報詳細
  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
  end

  private
   def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
   end


end
