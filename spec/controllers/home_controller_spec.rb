require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "#top" do
    it "returns http success" do
      get :top
      expect(response).to have_http_status(:success)
    end
  end

end
