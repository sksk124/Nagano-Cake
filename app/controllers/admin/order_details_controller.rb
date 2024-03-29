class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      redirect_to home_path(@order_detail.order), notice: "制作ステータスを更新しました"
    else
      render :edit
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
