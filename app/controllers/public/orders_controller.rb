class Public::OrdersController < ApplicationController
  #before_action :authenticate_member!

  def new #注文情報入力画面
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    # @orderはでかい箱で、その中に小さい箱を指定するためにストロングパラメーターを指定している。

    # if文を記述して、hidden fieldが作動するようにする。
    # ご自身の住所と配送先住所が選択された場合はhiddenで処理

    # 現在memberに登録されている住所であれば
    @customer = current_customer
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
        @order.shipping_postal_code = @customer.postal_code
        @order.shipping_address = @customer.address
        @order.shipping_name = @customer.sunname + @customer.name
    # collection.selectであれば
    elsif params[:order][:address_option] == "1"
        ship = Address.find(params[:order][:customer_id])
        @order.shipping_postal_code = ship.postal_code
        @order.shipping_address = ship.address
        @order.shipping_name = ship.name
    # 新規住所入力であれば
    elsif params[:order][:address_option] = "2"
        @order.shipping_postal_code = params[:order][:shipping_postal_code]
        @order.shipping_address = params[:order][:shipping_address]
        @order.shipping_name = params[:order][:shipping_name]
    else
        render 'new'
    end
    @cart_items = @customer.cart_items.all
    @order.customer_id = @customer.id
  end

  def create
    @customer = current_customer
    @order = Order.new(order_params)
    @order.member_id = @customer.id
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
    redirect_to thanx_orders_path
  end

  # 注文完了画面
  def thanx
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
     params.require(:order).permit(:customer_id, :address, :payment, :shipping_cost, :total_price, :order_status)
   end


end
