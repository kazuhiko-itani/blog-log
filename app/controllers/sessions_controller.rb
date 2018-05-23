class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    log_in user
    flash[:success] = 'ログインしました'
    redirect_back_or user
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end

  # テスト用のログインアクション
  def login
    user = User.find_by(name: params[:session][:name])
    log_in user
    flash[:success] = 'ログインしました'
    redirect_back_or user
  end
end
