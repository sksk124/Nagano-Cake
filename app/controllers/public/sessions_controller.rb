# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]


protected
# 退会しているかを判断するメソッド
def customer_state
  ## 【処理内容1】 入力されたemailからアカウントを1件取得
  @customer = Customer.find_by(email: params[:customer][:email])
  ## アカウントを取得できなかった場合、このメソッドを終了する
  return if !@customer
  ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致しているかを判別
  if @customer.valid_password?(params[:customer][:password])
    ## 【処理内容3】 取得したアカウントのis_deletedカラムに格納されている値を確認
    if @customer.is_deleted
      ## 退会している場合はサインアップ画面に遷移する
      redirect_to new_customer_registration_path, alert: "退会済みのアカウントです"
    else
      ## 退会していない場合は、createアクションを実行する
      create
    end
  end
end



  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
