require 'rails_helper'

RSpec.feature "UpdatingPosts", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) {FactoryGirl.create(:post, user: user)}

  # 投稿を更新後、削除する
  scenario 'user updates post and delete it' do
    log_in_as user
    # post = FactoryGirl.create(:post, user: user)
    visit edit_post_path(post)

    # 更新に失敗する
    find('#post_working_hours').set(30)
    find('#post_working_minutes').set(100)
    fill_in '作業内容', with: 'update'
    click_button '更新'

    expect(post.reload.memo).to_not eq 'update'
    expect(page).to have_tag '.alert-danger'

    # 更新に成功する
    find('#post_working_hours').set(1)
    find('#post_working_minutes').set(30)
    fill_in '作業内容', with: 'update'
    click_button '更新'

    expect(post.reload.memo).to eq 'update'
    expect(page).to have_tag '.alert-success'

    visit visit edit_post_path(post)
    expect {
      click_link '投稿の削除'
    }.to change(user.posts, :count).by(-1)
  end

  # ログイン処理
  def log_in_as(user)
    visit login_path

    fill_in 'ユーザー名', with: user.name
    click_button 'ログイン'
  end
end
