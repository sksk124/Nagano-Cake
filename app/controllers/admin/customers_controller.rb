class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.find(params[:customer_id])
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_numbe, :is_deleted)
  end

end
