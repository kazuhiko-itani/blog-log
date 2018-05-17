require 'rails_helper'

RSpec.feature "UpdatingUsers", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'ユーザー情報の編集' do
    log_in_as user
    visit edit_user_path(user)

    # 編集に失敗する
    fill_in 'ユーザー名', with: ' '
    fill_in 'プロフィール', with: ' '
    click_button '変更'

    expect(user.reload.name).to eq user.name
    expect(user.reload.profile).to eq user.profile
    expect(page).to have_tag '.alert-danger'

    # 編集に成功する（パスワードは空でも可）
    fill_in 'ユーザー名', with: 'success'
    attach_file 'プロフィールアイコン', "#{Rails.root}/spec/files/test.jpg"
    fill_in 'プロフィール', with: 'change profile'
    click_button '変更'

    expect(user.reload.name).to eq 'success'
    expect(user.reload.profile).to eq 'change profile'
    expect(user.reload.image).to have_content 'test.jpg'
    expect(page).to have_tag '.alert-success'

    # 退会する
    visit edit_user_path(user)
    expect {
      click_link '退会する'
    }.to change(User, :count).by(-1)
  end

  it 'フレンドリーフォワーディング' do
    visit edit_user_path(user)
    expect(current_path).to eq root_path

    log_in_as user
    expect(current_path).to eq edit_user_path(user)
  end

  # ログイン処理
  def log_in_as(user)
    visit login_path

    fill_in 'ユーザー名', with: user.name
    click_button 'ログイン'
  end
end
