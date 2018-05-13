class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    log_in user
    flash[:success] = 'ログインしました'
    redirect_to user
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました'
    redirect_to root_path
  end

  # 主にテスト用
  def login
    user = User.find_by(email: params[:session][:email].downcase)
    session[:user_id] = user.id
    redirect_to user
  end
end
