require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  # ログインに失敗する
  scenario 'mistake login' do
    visit login_path

    fill_in 'メールアドレス', with: ' '
    fill_in 'パスワード', with: ' '
    click_button 'ログイン'

    expect(page).to have_tag('.alert-danger')
    expect(page).to have_tag('a', 'ログイン')
  end

  # ログインに成功後、ログアウトする
  scenario 'success login and logout' do
    visit login_path

    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    expect(page).to have_tag('.alert-success')
    expect(page).to have_tag('a', 'ログアウト')

    click_link 'ログアウト'

    expect(page).to have_tag('.alert-success')
    expect(page).to have_tag('a', 'ログイン')
  end
end
