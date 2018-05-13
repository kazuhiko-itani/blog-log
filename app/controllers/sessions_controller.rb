class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    log_in user
    if user.name == '名無しさん'
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to edit_user_path(user)
    else
      flash[:success] = 'ログインしました'
      redirect_to user
    end
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました'
    redirect_to root_path
  end

  # テスト用のログインアクション
  def login
    user = User.find_by(name: params[:session][:name])
    log_in user
    if user.name == '名無しさん'
      log_in user
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to edit_user_path(user)
    else
      log_in user
      flash[:success] = 'ログインしました'
      redirect_to user
    end
  end
end
