require 'rails_helper'

RSpec.feature "Signups", type: :feature do

  # ユーザー登録失敗
  scenario 'mistake signup' do
    visit signup_path

    expect {
      fill_in 'ユーザー名', with: ' '
      fill_in 'メールアドレス', with: ' '
      fill_in 'パスワード（5文字以上）', with: ' '
      fill_in 'パスワード確認', with: ' '
      click_button '登録'
    }.to_not change(User, :count)

    expect(page).to have_tag('#error_explanation')
  end

  # ユーザー登録成功
  scenario 'success signup' do
    user = User.new(name: 'test', email: 'test@gmail.com',
                password: 'suisougaku', password_confirmation: 'suisougaku')

    visit signup_path
    expect {
      fill_in 'ユーザー名', with: user.name
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード（5文字以上）', with: user.password
      fill_in 'パスワード確認', with: user.password_confirmation
      click_button '登録'
    }.to change(User, :count).by(1)

    expect(page).to have_tag('.alert-success')
    expect(page).to have_content 'ログアウト'
  end
end
