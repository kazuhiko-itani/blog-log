require 'rails_helper'

RSpec.feature "Layouts", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  # ログイン前後のレイアウト
  scenario 'layout before login and after login' do
    visit root_path
    expect(page).to have_content 'ログイン'
    expect(page).to have_content '新規登録'

    log_in_as user
    visit root_path

    expect(page).to_not have_content 'ログイン'
    expect(page).to_not have_content '新規登録'
  end

  # テスト用のログインフォームからログイン
  def log_in_as(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end
