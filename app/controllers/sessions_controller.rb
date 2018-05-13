class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    if user.name != '名無しさん'
      log_in user
      flash[:success] = 'ログインしました'
      redirect_to user
    else
      log_in user
      flash[:success] = 'ユーザー登録に成功しました'
      redirect_to edit_user_path(user)
    end
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました'
    redirect_to root_path
  end

  # 主にテスト用
  def login
    user = User.find_by(name: params[:session][:name])
    session[:user_id] = user.id
    redirect_to user
  end
end
