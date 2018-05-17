require 'rails_helper'

RSpec.feature "CreateNewPosts", type: :feature do

  scenario '新しいpostを作成する' do
    user = FactoryGirl.create(:user)
    log_in_as(user)

    # 無効な値を入力
    visit new_post_path
    expect {
      find('#post_working_hours').set(30)
      find('#post_working_minutes').set(100)
      fill_in '作業内容', with: '記事更新'
      click_button '登録'
    }.to_not change(user.posts, :count)

    expect(page).to have_tag '.alert-danger'

    # 正しい値を入力
    visit new_post_path
    expect {
      find('#post_working_hours').set(1)
      find('#post_working_minutes').set(30)
      fill_in '作業内容', with: '記事更新'
      click_button '登録'
    }.to change(user.posts, :count).by(1)

    expect(current_path).to eq user_path(user)
    expect(page).to have_tag '.alert-success'
    expect(page).to have_content '記事更新'
  end

  # ログイン処理
  def log_in_as(user)
    visit login_path

    fill_in 'ユーザー名', with: user.name
    click_button 'ログイン'
  end
end
