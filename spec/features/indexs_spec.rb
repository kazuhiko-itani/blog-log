require 'rails_helper'

RSpec.feature "Indexs", type: :feature do
  before do
    @user = FactoryGirl.create(:user, :admin)
    31.times do
      FactoryGirl.create(:post, :date_today)
    end
  end

  scenario 'ユーザー一覧ページに移動し、ユーザー名のリンクからユーザー詳細ページに移動する' do
    # visit users_path
    # expect(page).to have_tag '.pagination'
    # expect(page).to have_content 'Test memo'

    # find('#today-table').click_link 'admin'
    # expect(current_path).to eq user_path(@user)
    # expect(page).to have_content 'まだ投稿はありません'
    # 非ログイン状態では「編集」のリンクがないことを確認
    # expect(page).to_not have_tag('a', :text => '編集')
  end
end
