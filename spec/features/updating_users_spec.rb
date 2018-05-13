require 'rails_helper'

RSpec.feature "UpdatingUsers", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  # ユーザー情報の編集
  scenario 'updating user data' do
    visit login_path

    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    visit edit_user_path(user)

    # 編集に失敗する
    fill_in 'ユーザー名', with: ' '
    fill_in 'メールアドレス', with: ' '
    fill_in 'パスワード（5文字以上）', with: ' '
    fill_in 'パスワード（確認）', with: ' '
    click_button '変更'

    expect(user.reload.name).to eq user.name
    expect(page).to have_tag('.alert-danger')

    # 編集に成功する（パスワードは空でも可）
    fill_in 'ユーザー名', with: 'success'
    fill_in 'メールアドレス', with: 'test@gmail.com'
    fill_in 'パスワード（5文字以上）', with: ''
    fill_in 'パスワード（確認）', with: ''
    click_button '変更'

    expect(user.reload.name).to eq 'success'
    expect(page).to have_tag('.alert-success')
  end
end
