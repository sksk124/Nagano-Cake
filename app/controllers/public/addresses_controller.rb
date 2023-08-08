class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: "配送先を追加しました。"
    else
      @addresses = current_customer.addresses.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
    if @address.customer != current_customer
      redirect_to addresses_path
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先を編集しました。"
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path, notice: "配送先を削除しました。"
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end



end
