class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.find(params[:customer_id])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
   if @customer.update(customer_params)
    flash[:success] = "顧客情報を更新しました"
    redirect_to admin_customer_path(@customer)
   else
    flash.now[:error] = "顧客情報の更新に失敗しました"
    render :edit
   end
  end

  def destroy
   @customer = Customer.find(params[:id])
   @customer.destroy
   flash[:success] = "顧客情報を削除しました"
   redirect_to admin_customers_path
  end




  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end

end
