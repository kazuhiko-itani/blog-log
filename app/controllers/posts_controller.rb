class PostsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = current_user.posts.build if logged_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.caluculate_working_total
    if @post.save
      flash[:success] = '記録しました'
      redirect_to current_user
    else
      render 'new'
    end
  end

  def edit
    @post.convert_working_total
  end

  def update
    if @post.update_attributes(post_params)
      # 更新されたworking_hoursとworking_minutesでworking_totalを算出
      @post.caluculate_working_total
      @post.update_attributes(working_total: @post.working_total)
      flash[:success] = '投稿を更新しました'
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to user_url(current_user)
  end

  private
    def post_params
      params.require(:post).permit(:date, :working_hours, :working_minutes, :memo)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
