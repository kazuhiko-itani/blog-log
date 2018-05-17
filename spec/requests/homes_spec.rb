require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe '#root' do

    it '正常なレスポンスを返すこと' do
      get root_path
      expect(response).to have_http_status '200'
    end
  end

  describe '#help' do

    it '正常なレスポンスを返すこと' do
      get help_path
      expect(response).to have_http_status '200'
    end
  end
end
