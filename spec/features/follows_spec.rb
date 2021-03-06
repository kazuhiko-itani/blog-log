require 'rails_helper'

RSpec.feature "Follows", type: :feature do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  scenario 'ログインの有無によってフォローボタンの表示、非表示が切り替わる' do
    # 非ログイン状態ではフォローボタンが表示されない
    visit user_path(user)
    expect(page).to_not have_tag('.follow-form')

    # ログイン状態でも、自分のページにはフォローボタンは表示されない
    login_as user
    visit user_path(user)
    expect(page).to_not have_tag('.follow-form')

    # ログイン状態、かつ他のユーザーページに移動した場合はフォローボタンが表示される
    visit user_path(other_user)
    expect(page).to have_tag('.follow-form')
  end

  scenario 'ユーザーをフォロー/アンフォローし、フォロー一覧ページに反映されることを確認' do
    # ログインし、ユーザーをフォロー
    login_as user
    visit user_path(other_user)
    find('.follow-btn').click

    # フォロー一覧ページで確認
    visit following_user_path(user)
    expect(page).to have_content other_user.name

    # フォローしたユーザーをアンフォローする
    visit user_path(other_user)
    find('.follow-btn').click

    # フォロー一覧ページで確認
    visit following_user_path(user)
    expect(page).to_not have_content other_user.name
  end

  # ログイン処理
  def login_as(user)
    page.set_rack_session(user_id: user.id)
  end
end
