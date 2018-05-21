require 'rails_helper'

RSpec.feature "SearchUsers", type: :feature do

  before do
    @admin = FactoryGirl.create(:user, :admin)
    @user = FactoryGirl.create(:user, name: 'test')

    FactoryGirl.create(:post, user: @admin)
    FactoryGirl.create(:post, user: @user)
  end

  scenario 'ユーザー一覧ページからadminを検索する' do
    visit users_path
    expect(page).to have_content @admin.name
    expect(page).to have_content @user.name

    find('#q_name_cont').set('admin')
    find('.btn-search').click

    expect(current_path).to eq search_result_users_path
    expect(page).to have_content @admin.name
    expect(page).to_not have_content @user.name
  end
end
