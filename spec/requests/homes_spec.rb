require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe '#home' do

    # 正常なレスポンスを返すこと
    it 'respondes successfully' do
      get root_path
      expect(response).to have_http_status '200'
    end
  end
end
