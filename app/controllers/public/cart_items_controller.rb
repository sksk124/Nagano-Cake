class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
  end

 def create
  # 追加しようとしている商品が既にカート内に存在するかを判定
   if (existing_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]))
  # カート内に存在する場合、個数をフォームから送られた個数分増やす
    existing_cart_item.amount += params[:cart_item][:amount].to_i
    existing_cart_item.save
   else
  # カート内に存在しなかった場合、新しいカートアイテムを作成する
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_item.save
   end
   
   redirect_to cart_items_path
 end
 
 
 def update
  cart_item = CartItem.find(params[:id])
  cart_item.update(cart_item_params)
  redirect_to cart_items_path, notice: "カート内の商品を更新しました。"
 end
 
 
 
 

  def destroy
   @cart_item = current_customer.cart_items.find(params[:id])
   @cart_item.destroy
   redirect_to cart_items_path, notice: "カートから商品を削除しました。"
  end
  
  def destroy_all
   current_customer.cart_items.destroy_all
   redirect_to cart_items_path, notice: "カートを空にしました。"
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
