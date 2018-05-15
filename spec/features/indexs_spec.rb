require 'rails_helper'

RSpec.feature "Indexs", type: :feature do
  before do
    @user = FactoryGirl.create(:user, :admin)
    31.times do
      FactoryGirl.create(:user)
    end
  end

  # ユーザー一覧ページに移動し、ユーザー名のリンクからユーザー詳細ページに移動する
  scenario 'user accesses user-index page and click link for user-show page' do
    visit users_path
    expect(page).to have_tag '.pagination'

    click_link 'admin'
    expect(current_path).to eq user_path(@user)
  end
end
