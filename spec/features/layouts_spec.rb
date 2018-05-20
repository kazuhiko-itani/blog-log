require 'rails_helper'

RSpec.feature "Layouts", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  # ログイン前後のレイアウト
  scenario 'layout before login and after login' do
    visit root_path
    expect(page).to have_tag('a', :text => 'ログイン/新規登録')

    log_in_as user
    visit root_path

    expect(page).to_not have_tag('a', :text => 'ログイン/新規登録')
  end

  scenario 'ユーザーページにツイートボタンがあることを確認' do
    # ログインしていなければツイートボタンが表示されないこと
    visit user_path(user)
    expect(page).to_not have_tag('.tweet-btn')

    # ログインしていれば自分のユーザーページにツイートボタンが表示されること
    log_in_as user
    visit user_path(user)
    expect(page).to have_tag('.tweet-btn')

    # 自分以外のユーザーページにはツイートボタンがないこと
    visit user_path(other_user)
    expect(page).to_not have_tag('.tweet-btn')
  end

  # テスト用のログインフォームからログイン
  def log_in_as(user)
    visit login_path
    fill_in 'ユーザー名', with: user.name
    click_button 'ログイン'
  end
end
