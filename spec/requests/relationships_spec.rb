require 'rails_helper'

RSpec.describe "Relationships", type: :request do

  describe '#create' do

    it '非ログイン状態ではトップページにリダイレクトされること' do
      relationship = FactoryGirl.attributes_for(:relationship)
      post relationships_path, params: { relationship: relationship }
      expect(response).to redirect_to root_path
    end
  end

  describe '#destroy' do

    it '非ログイン状態ではトップページにリダイレクトされること' do
      relationship = FactoryGirl.create(:relationship)
      delete relationship_path(relationship)
      expect(response).to redirect_to root_path
    end
  end
end
