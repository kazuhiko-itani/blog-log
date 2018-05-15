require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }


  describe '#new' do

    # 非ログイン状態ではリダイレクトされること
    it 'redirects without login' do
      get new_post_path
      expect(response).to have_http_status '302'
    end

    # ログイン状態であればログインできること
    it 'success access with login' do
      login_as user
      get new_post_path
      expect(response).to have_http_status '200'
    end
  end

  describe '#create' do

    # 非ログイン状態ではトップページにリダイレクトされること
    it 'redirects to top-page without login' do
      post_params = FactoryGirl.attributes_for(:post)
      post posts_path, params: { post: post_params }
      expect(response).to redirect_to root_url
    end

    # ログイン状態ではpost投稿後、ユーザー詳細ページにリダイレクトされること
    it 'redirects to top-page without login' do
      login_as user
      post_params = FactoryGirl.attributes_for(:post)
      post posts_path, params: { post: post_params }
      expect(response).to redirect_to user_url(user)
    end
  end

  describe '#edit' do
    before do
      @user_post = FactoryGirl.create(:post, user: user)
      @other_user_post = FactoryGirl.create(:post, user: other_user)
    end

    # 非ログイン状態ではリダイレクトされること
    it 'redirects without login' do
      get edit_post_path(@user_post)
      expect(response).to have_http_status '302'
    end

    # ログイン状態でも違うユーザーのpostの場合はリダイレクトされること
    it 'redirects when logged in wrong user' do
      login_as user
      get edit_post_path(@other_user_post)
      expect(response).to have_http_status '302'
    end

    # ログイン状態、かつ自分のpostの場合はアクセスできること
    it 'success access when logged in and access my post' do
      login_as user
      get edit_post_path(@user_post)
      expect(response).to have_http_status '200'
    end
  end

  describe '#update' do
    before do
      @user_post = FactoryGirl.create(:post, user: user)
      @other_user_post = FactoryGirl.create(:post, user: other_user)
    end

    # 非ログイン状態ではトップページにリダイレクトされること
    it 'redirects to top-page without login' do
      patch post_path(@user_post), params: { post: {
                            date: '201-05-05',
                            working_hours: '2',
                            working_minutes: '30',
                            memo: 'test'
        }
      }
      expect(response).to redirect_to root_path
    end

    # ログイン状態でも違うユーザーのpostの場合はリダイレクトされること
    it 'redirects to top-page when logged in wrong user' do
      login_as user
      patch post_path(@other_user_post), params: { post: {
                            date: '201-05-05',
                            working_hours: '2',
                            working_minutes: '30',
                            memo: 'test'
        }
      }
      expect(response).to redirect_to root_path
    end

    # ログイン状態、かつ本人のpostの場合は更新後、ユーザー詳細ページへリダイレクトされること
    it 'redirects to user-show when logged in and my post' do
      login_as user
      patch post_path(@user_post), params: { post: {
                            date: '201-05-05',
                            working_hours: '2',
                            working_minutes: '30',
                            memo: 'test'
        }
      }
      expect(response).to redirect_to user_path(user)
    end
  end

  describe '#destroy' do
    before do
      @user_post = FactoryGirl.create(:post, user: user)
      @other_user_post = FactoryGirl.create(:post, user: other_user)
    end

    # 非ログイン状態ではトップページへリダイレクトされること
    it 'redirects without login' do
      delete post_path(@user_post)
      expect(response).to redirect_to root_url
    end

    # ログイン状態でも違うユーザーのpostの場合はリダイレクトされること
    it 'redirects when logged in wrong user' do
      login_as user
      delete post_path(@other_user_post)
      expect(response).to redirect_to root_url
    end

    # ログイン状態、かつ自分のpostの場合は削除後、ユーザー詳細ページへリダイレクトされること
    it 'success access when logged in and access my post' do
      login_as user
      delete post_path(@user_post)
      expect(response).to redirect_to user_url(user)
    end
  end

  # ログインメソッド
  def login_as(user)
    post '/test/login', params: { session: {
                  name: user.name
        }
      }
  end
end
