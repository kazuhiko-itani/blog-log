class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy, :following]
  before_action :correct_user, only: [:edit, :update, :destroy, :following]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])

    post_today = @user.posts.find_by(date: Date.today)
    today_working_total = post_today ? post_today.working_total : 0
    @working_today_hour, @working_today_minute =
                    convert_today_working_total_to_hours_and_minutes(today_working_total)
  end

  def index
    # ランダム表示用のインスタンス変数
    users_have_weekly_data = User.all.reject {
      |user| user.posts.where(date: (Date.today - 7)... Date.today).blank?
    }.shuffle
    @users_weekly = Kaminari.paginate_array(users_have_weekly_data).page(params[:page]).per(25)

    # 「今日」「昨日」表示用のインスタンス変数
    @posts_today = Post.where(date: Date.today).order(working_total: :desc).page(params[:page])
    @posts_yesterday = Post.where(date: Date.yesterday).order(working_total: :desc).page(params[:page])
    @q = User.ransack(distinct: true)
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following.page(params[:page])
  end

  def search_form
    @q = User.ransack(distinct: true)
  end

  def search_result
    if params[:q]
      @q = User.ransack(search_params)
      @search_user = @q.result.paginate(page: params[:page])
    else
      redirect_to users_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
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
      params.require(:user).permit(:name, :profile, :blog_url, :twitter_url, :image)
    end

    def search_params
      params.require(:q).permit(:name_cont)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user || current_user.admin?
    end
end
