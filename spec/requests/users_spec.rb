require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  describe '#index' do

    it '正常なレスポンスを返すこと' do
      FactoryGirl.create(:user)
      get users_path
      expect(response).to have_http_status '200'
    end
  end

  describe '#edit' do

    it '非ログイン状態ではリダイレクトされること' do
      get edit_user_path(user)
      expect(response).to have_http_status '302'
    end

    it 'ログイン状態でも、本人以外であればリダイレクトされること' do
      login_as other_user
      get edit_user_path(user)
      expect(response).to have_http_status '302'
    end

    it 'ログイン状態、かつ本人であればアクセスできること' do
      login_as user
      get edit_user_path(user)
      expect(response).to have_http_status '200'
    end
  end

  describe '#update' do

    it '非ログイン状態ではログイン画面にリダイレクトされること' do
      patch user_path(user), params: { user: {
                      name: user.name
        }
      }
      expect(response).to redirect_to root_url
    end

      it 'ログイン状態でも、本人以外であればトップページにリダイレクトされること' do
        login_as other_user
        patch user_path(user), params: { user: {
                      name: other_user.name
          }
        }
        expect(response).to redirect_to root_url
      end

    it 'ログイン状態、かつ本人であれば編集に成功後、ユーザー詳細ページにリダイレクトされること' do
      login_as user
      patch user_path(user), params: { user: {
                      name: user.name
        }
      }
      expect(response).to redirect_to user_url(user)
    end

    it 'admin属性を含む更新は無効であること' do
      login_as user
      patch user_path(user), params: { user: {
                      name: user.name,
                      admin: true
        }
      }
      expect(user.reload.admin).to be false
    end
  end

  describe '#destroy' do

    it '非ログイン状態ではトップページにリダイレクトされること' do
      delete user_path(user)
      expect(response).to redirect_to root_url
    end

    it 'ログイン状態でも、本人以外であればトップページにリダイレクトされること' do
      login_as user
      delete user_path(other_user)
      expect(response).to redirect_to root_url
    end

    it 'ログイン状態、かつ本人であれば削除処理の後、ユーザー一覧ページにリダイレクトされること' do
      login_as user
      delete user_path(user)
      expect(response).to redirect_to users_url
    end

    it '管理者（admin）であれば他のユーザーを削除でき、処理後にユーザー一覧ページにリダイレクトされること' do
      admin = FactoryGirl.create(:user, :admin)
      login_as admin
      delete user_path(other_user)
      expect(response).to redirect_to users_url
    end
  end

  describe '#search' do

    it '検索フォームを経由しないアクセスはユーザー一覧ページにリダイレクトされること' do
      get search_result_users_path
      expect(response).to redirect_to users_url
    end

    it '検索フォームを経由すれば正常にアクセスできること' do
      get search_result_users_path, params: { q: {
                                  name_cont: 'admin'
        }
      }
      expect(response).to have_http_status '200'
    end
  end

  describe '#following' do

    it '非ログイン状態ではトップページにリダイレクトされること' do
      get following_user_path(user)
      expect(response).to redirect_to root_url
    end

    it 'ログイン状態でも本人以外であればトップページにリダイレクトされること' do
      login_as user
      get following_user_path(other_user)
      expect(response).to redirect_to root_url
    end

    it 'ログイン状態かつ本人なら正常にアクセスできること' do
      login_as user
      get following_user_path(user)
      expect(response).to have_http_status '200'
    end
  end

  # ログインメソッド
  def login_as(user)
    post '/test/login', params: { session: { name: user.name } }
  end
end
