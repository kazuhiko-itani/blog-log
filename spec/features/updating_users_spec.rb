require 'rails_helper'

RSpec.feature "UpdatingUsers", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'ユーザー情報の編集' do
    login_as user
    visit edit_user_path(user)

    # 編集に失敗する
    fill_in 'ユーザー名', with: ' '
    fill_in 'プロフィール', with: ' '
    fill_in 'ブログ（サイト）URL', with: ' '
    click_button '変更'

    expect(user.reload.name).to_not eq ' '
    expect(user.reload.profile).to_not eq ' '
    expect(user.reload.blog_url).to_not eq ' '
    expect(page).to have_tag '.alert-danger'

    # 編集に成功する（パスワードは空でも可）
    fill_in 'ユーザー名', with: 'success'
    fill_in 'プロフィール', with: 'change profile'
    fill_in 'ブログ（サイト）URL', with: 'http://change-brog-url'
    attach_file 'プロフィールアイコン', "#{Rails.root}/spec/files/test.jpg"
    click_button '変更'

    expect(user.reload.name).to eq 'success'
    expect(user.reload.profile).to eq 'change profile'
    expect(user.reload.blog_url).to eq 'http://change-brog-url'
    expect(user.reload.image).to have_content 'test.jpg'
    expect(page).to have_tag '.alert-success'

    # 退会する
    visit edit_user_path(user)
    expect {
      click_link '退会する'
    }.to change(User, :count).by(-1)
  end

  # ログイン処理
  def login_as(user)
    page.set_rack_session(user_id: user.id)
  end
end
