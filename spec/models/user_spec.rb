require 'rails_helper'

RSpec.describe User, type: :model do

  it '有効なファクトリを持つこと' do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  it 'ユーザーが削除されると紐ついた投稿も削除されること' do
    post = FactoryGirl.create(:post)
    expect(Post.count).to eq 1

    post.user.destroy
    expect(Post.count).to eq 0
  end

  context 'バリデーションテスト（name）' do

    it '名前がなければ無効であること' do
      user = FactoryGirl.build(:user, name: nil)
      expect(user.valid?).to be false
    end

    it '名前が長すぎると無効であること' do
      user = FactoryGirl.build(:user, name: 'a' * 51)
      expect(user.valid?).to be false
    end
  end

  context 'バリデーションテスト（profile）' do

    it '長すぎるプロフィールは無効であること' do
      user = FactoryGirl.build(:user, profile: 'a' * 151)
      expect(user.valid?).to be false
    end
  end

  context 'バリデーションテスト(blog_url)' do

    it '長すぎる（無意味な）URLは無効であること' do
      user = FactoryGirl.build(:user, blog_url: 'http://blog.' + ('a' * 100))
      expect(user.valid?).to be false
    end
  end
end
