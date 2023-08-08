class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @cart_items = current_customer.cart_items # カートアイテムを表すモデルから注文する商品の情報を取得
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end


  def confirm
   @order = Order.new(order_params)
   @order.payment_method = params[:order][:payment_method]
  case params[:order][:select_address]
  when "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
  when "1"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  when "2"
    @address = current_customer.addresses.new
    @address.postal_code = params[:order][:postal_code]
    @address.address = params[:order][:address]
    @address.name = params[:order][:name]
    @address.save
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end
  end


  def create
   @order = Order.new(order_params)
#1. 確認画面から送られてきた、配送先・支払い方法を取得
   subtotal = 0
    current_customer.cart_items.each do |item|
    subtotal += (item.item.price * item.amount * 1.1).floor
   end
   @order.shipping_cost = 800
   @order.status = 0
   @order.customer_id = current_customer.id
   @order.total_payment = subtotal + @order.shipping_cost
   @order.total_items = current_customer.cart_items.sum(:amount)
#2. カート内の合計金額から請求金額を算出
   @order.save!
#3. 注文(Order)モデルに注文を保存
   current_customer.cart_items.each do |cart_item|
   order_detail = OrderDetail.new
   order_detail.order_id = @order.id
   order_detail.item_id = cart_item.item_id
   order_detail.price = cart_item.item.price
   order_detail.amount = cart_item.amount
   order_detail.making_status = 1
   order_detail.save
   cart_item.destroy
  end
#4. 注文詳細(OrderDetail)モデルにカート内商品の情報をもとに保存
#5. 注文者のカート内商品を全て削除
   redirect_to complete_orders_path
#6. 購入完了画面に遷移

  end

  def destroy_all
   Order.destroy_all
   redirect_to root_path, notice: "全ての注文を削除しました。"
  end






  def complete
#   @order = Order.new

#   subtotal = 0
#   current_customer.cart_items.each do |item|
#   subtotal += item.item.price * item.amount
#   end

#   @order.shipping_cost = 800
#   @order.total_payment = subtotal + @order.shipping_cost

#   @order.postal_code = params[:order][:postal_code]
#   @order.address = params[:order][:address]
#   @order.name = params[:order][:name]
#   @order.payment_method = params[:order][:payment_method]

#   @order.save

#   current_customer.cart_items.each do |cart_item|
#   order_detail = OrderDetail.new
#   order_detail.order_id = @order.id
#   order_detail.item_id = cart_item.item_id
#   order_detail.price = cart_item.item.price
#   order_detail.amount = cart_item.amount
#   order_detail.save
#   end

#   current_customer.cart_items.each do |cart_item|
#   cart_item.destroy
#   end

#   redirect_to complete_orders_path

  end





  private

  def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment, :total_items)
  end


end
