require 'rails_helper'

RSpec.feature "Follows", type: :feature do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  scenario 'ログインの有無によってフォローボタンの表示、非表示が切り替わる' do
    # 非ログイン状態ではフォローボタンが表示されない
    visit user_path(user)
    expect(page).to_not have_tag('.follow-form')

    # ログイン状態でも、自分のページにはフォローボタンは表示されない
    log_in_as user
    visit user_path(user)
    expect(page).to_not have_tag('.follow-form')

    # ログイン状態、かつ他のユーザーページに移動した場合はフォローボタンが表示される
    visit user_path(other_user)
    expect(page).to have_tag('.follow-form')
  end

  # ログイン処理
  def log_in_as(user)
    visit login_path

    fill_in 'ユーザー名', with: user.name
    click_button 'ログイン'
  end
end
