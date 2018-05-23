require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "#create" do

    it 'ログイン/新規登録後、ユーザーページへ移動する' do
      user = FactoryGirl.create(:user)
      post '/test/login', params: { session: { name: user.name } }
      expect(response).to redirect_to user_url(user)
    end
  end
end
