require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  describe '#new' do

    # 正常なレスポンスを返すこと
    it 'responds successfully' do
      get signup_path
      expect(response).to have_http_status '200'
    end
  end

  describe '#edit' do

      # 非ログイン状態ではリダイレクトされること
      it 'redirect without login' do
        get edit_user_path(user)
        expect(response).to have_http_status '302'
      end

      # ログイン状態でも、本人以外であればリダイレクトされること
      it 'redirect when logged in wrong user' do
        login_as(other_user)
        get edit_user_path(user)
        expect(response).to have_http_status '302'
      end

      # ログイン状態、かつ本人であればアクセスできること
      it 'success access with login and correct user' do
        login_as(user)
        get edit_user_path(user)
        expect(response).to have_http_status '200'
      end
    end

  describe '#update' do

    # 非ログイン状態ではログイン画面にリダイレクトされること
    it 'redirect to login-page without login' do
      patch user_path(user), params: { user: {
                      name: user.name,
                      email: user.email,
                      password: user.password,
                      password_confirmation: user.password_confirmation
        }
      }
      expect(response).to redirect_to(login_url)
    end

    # ログイン状態でも、本人以外であればトップページにリダイレクトされること
      it 'redirect to top-page when logged in wrong user' do
        login_as(other_user)
        patch user_path(user), params: { user: {
                      name: other_user.name,
                      email: other_user.email,
                      password: other_user.password,
                      password_confirmation: other_user.password_confirmation
          }
        }
        expect(response).to redirect_to(root_url)
      end

    # ログイン状態、かつ本人であれば編集に成功後、ユーザー詳細ページにリダイレクトされること
    it 'redirect to show-page with login' do
      login_as(user)
      patch user_path(user), params: { user: {
                      name: user.name,
                      email: user.email,
                      password: user.password,
                      password_confirmation: user.password_confirmation
        }
      }
      expect(response).to redirect_to(user_url(user))
    end
  end

  def login_as(user)
    post '/test/login', params: { session: {
                  email: user.email,
                  password: user.password
        }
      }
  end
end
