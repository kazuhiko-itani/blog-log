class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # 一時的に不要
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @working_hours = caluculate_working_times_sum(@posts) / 60
    @working_minutes = caluculate_working_times_sum(@posts) % 60
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

  def index
    users_have_today_data = User.all.reject {
      |user| user.posts.where(date: Date.today).blank?
    }.shuffle
    @users_random = Kaminari.paginate_array(users_have_today_data).page(params[:page]).per(15)

    users_have_weekly_data = User.all.reject {
      |user| user.posts.where(date: (Date.today - 7)... Date.today).blank?
    }.shuffle
    @users_weekly = Kaminari.paginate_array(users_have_weekly_data).page(params[:page]).per(15)

    @posts_today = Post.where(date: Date.today).order(working_total: :desc).page(params[:page])
    @q = User.ransack(distinct: true)
  end

  def search
    if params[:q]
      @q = User.ransack(search_params)
      @search_user = @q.result.paginate(page: params[:page])
    else
      redirect_to users_path
    end
  end

  def result
  end

  def edit
  end

  def update
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

  def destroy
    @user.destroy
    flash[:info] = 'ユーザー記録を削除しました'
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :image, :profile, :blog_url)
    end

    def search_params
      params.require(:q).permit(:name_cont)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user || current_user.admin?
    end
end
