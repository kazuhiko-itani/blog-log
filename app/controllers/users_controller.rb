class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  # 一時的に不要
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  # 一時的に不要
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:name] == '名無しさん'
      flash[:danger] = '名前を変更してください'
      render 'edit'
    elsif @user.update_attributes(user_params)
      flash[:success] = 'ユーザー情報を編集しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :image_url)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'ログインが必要なページです'
        redirect_to root_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
