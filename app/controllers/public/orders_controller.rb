class Public::OrdersController < ApplicationController


  def new
    @order = Order.new
    @customer = current_customer
  end


  def create
   @order = Order.new(order_params)
   @order.postal_code = params[:order][:postal_code]
   @order.address = params[:order][:address]
   @order.name = params[:order][:name]
   # その他の処理
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :address, :payment_method)
  end


end
