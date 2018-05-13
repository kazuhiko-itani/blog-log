require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "#create" do

    # Twitter apiによるログイン/新規登録の挙動テスト
    context 'login or signup with twiiter api' do

      # 処理後、ユーザー名が「名無しさん」の場合は新規登録扱いとなり、editページへ移動する
      it 'redirect to edit when user_name is 名無しさん' do
        user = FactoryGirl.create(:user, name: '名無しさん')
        post '/test/login', params: { session: { name: '名無しさん' } }
        expect(response).to redirect_to edit_user_url(user)
      end

      # 処理後、ユーザー名が「名無しさん」以外の場合はログイン扱いとなり、詳細ページへ移動する
      it 'redirect to show when user_name is not 名無しさん' do
        user = FactoryGirl.create(:user)
        post '/test/login', params: { session: { name: user.name } }
        expect(response).to redirect_to user_url(user)
      end
    end
  end
end
