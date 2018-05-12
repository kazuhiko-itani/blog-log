require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe '#new' do

    # 正常なレスポンスを返す
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do

    # 正常なレスポンスを返す
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#destroy' do

    # 正常なレスポンスを返す
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

end
