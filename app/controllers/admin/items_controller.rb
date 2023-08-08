class Admin::ItemsController < ApplicationController

  def index
    @items = Item.all
    @genre_id = params[:genre_id]
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.image_id = params[:item][:image] # 画像をアタッチする前に、image_idを初期化する
   if @item.save
    redirect_to admin_item_path(@item)
   else
    render :new
   end
  end


  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to admin_items_path, notice: "商品を削除しました"
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :genre_id, :image)
  end

end
