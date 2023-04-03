class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:show, :edit, :update]

  def new
    @customer = Customer.new
  end

  def show
    @customer = current_customer
  end

  def create
   @cart_item = current_customer.cart_items.build(cart_item_params)
   @cart_item.save
   redirect_to cart_items_path
  end



  def edit
  end

  def update
   if @customer.update(customer_params)
     redirect_to customers_my_page_path, notice: 'Customer was successfully updated.'
   else
     render :edit
   end
  end


  def unsubscribe
    # フォーム用のオブジェクトを作成
    @customer = Customer.new
  end

  def withdraw
  # フォームから送信されたパスワードとパスワード確認用の値を取得する
  password = params[:password]
  password_confirmation = params[:password_confirmation]
 # パスワードとパスワード確認用の値が一致しているかを確認する
   if password == password_confirmation
    # 論理削除のため、is_deletedカラムをtrueに更新する
    current_customer.update(is_deleted: true)

    # ログアウトさせる
    reset_session

    # 退会が完了した旨のメッセージを表示し、トップページへリダイレクトする
    flash[:notice] = "退会が完了しました。ご利用ありがとうございました。"
    redirect_to top_path
   else
    # パスワードとパスワード確認用の値が一致しない場合はエラーメッセージを表示する
    flash.now[:alert] = "パスワードとパスワード確認用の値が一致しません。"
    redirect_to customers_my_page_path
   end
  end



  private

  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password)
  end

  def set_customer
    @customer = current_customer
  end
  

end
