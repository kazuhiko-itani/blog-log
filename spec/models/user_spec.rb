require 'rails_helper'

RSpec.describe User, type: :model do

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  # ユーザーが削除されると紐ついた投稿も削除されること
  it 'delete associated-post when user is deleted' do
    post = FactoryGirl.create(:post)
    expect(Post.count).to eq 1

    post.user.destroy
    expect(Post.count).to eq 0
  end

  #バリデーションテスト

  context 'name validate' do

    # 名前がなければ無効であること
    it 'is invalid without a name' do
      user = FactoryGirl.build(:user, name: nil)
      expect(user.valid?).to be false
    end

    # 名前が長すぎると無効であること
    it 'is invalid with too long name' do
      user = FactoryGirl.build(:user, name: 'a' * 51)
      expect(user.valid?).to be false
    end
  end
end
