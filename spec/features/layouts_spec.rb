require 'rails_helper'

RSpec.feature "Layouts", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  scenario 'ログイン前後のレイアウト' do
    visit root_path
    expect(page).to have_tag('a', :text => 'ログイン/新規登録')

    login_as user
    visit root_path

    expect(page).to_not have_tag('a', :text => 'ログイン/新規登録')
  end

  scenario 'ユーザーページにツイートボタンがあることを確認' do
    # ログインしていなければツイートボタンが表示されないこと
    visit user_path(user)
    expect(page).to_not have_tag('.tweet-btn')

    # ログインしていれば自分のユーザーページにツイートボタンが表示されること
    login_as user
    visit user_path(user)
    expect(page).to have_tag('.tweet-btn')

    # 自分以外のユーザーページにはツイートボタンがないこと
    visit user_path(other_user)
    expect(page).to_not have_tag('.tweet-btn')
  end

  # ログイン処理
  def login_as(user)
    page.set_rack_session(user_id: user.id)
  end
end
