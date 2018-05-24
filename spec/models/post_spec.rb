require 'rails_helper'

RSpec.describe Post, type: :model do

  it '有効なファクトリを持つこと' do
    post = FactoryGirl.create(:post)
    expect(post).to be_valid
  end

  it '最新の投稿順にデータが抽出されること' do
    post1 = FactoryGirl.create(:post, :date_yesterday)
    post2 = FactoryGirl.create(:post)
    post3 = FactoryGirl.create(:post, :date_tomorrow)
    expect(Post.first).to eq post3
  end

  context 'バリデーションテスト（date）' do

    it '日付が入力されていなければ無効であること' do
      post = FactoryGirl.build(:post, date: nil)
      expect(post.valid?).to be false
    end

    it '1人のユーザーは投稿日が同じpostを持てないこと' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:post, user: user)
      post = FactoryGirl.build(:post, user: user)
      expect(post.valid?).to be false
    end

    it '異なるユーザーであれば、投稿日が同じpostを持てること' do
      FactoryGirl.create(:post, date: '2018-05-05')
      other_user = FactoryGirl.create(:user)
      post = FactoryGirl.build(:post, user: other_user, date: '2018-05-05')
      expect(post.valid?).to be true
    end
  end

  context 'バリデーションテスト（memo）' do

    it '50文字を超えるメモを持つ投稿は無効であること' do
      post = FactoryGirl.build(:post, memo: 'a' * 51)
      expect(post.valid?).to be false
    end
  end

  context 'バリデーションテスト（working_total）' do

    it '作業時間が入力されていなければ無効であること' do
      post = FactoryGirl.build(:post, working_total: nil)
      expect(post.valid?).to be false
    end
  end

  context 'バリデーションテスト（working_hours）' do

    it '作業時間が入力されていなければ無効であること' do
      post = FactoryGirl.build(:post, working_hours: nil)
      expect(post.valid?).to be false
    end

    it '文字列の入力は無効であること' do
      post = FactoryGirl.build(:post, working_hours: '1時間')
      expect(post.valid?).to be false
    end

    it '少数点の入力は無効であること' do
      post = FactoryGirl.build(:post, working_hours: 1.5)
      expect(post.valid?).to be false
    end

    it '24以上の数字は無効であること' do
      post = FactoryGirl.build(:post, working_hours: 24)
      expect(post.valid?).to be false
    end

    it 'マイナスの入力は無効であること' do
      post = FactoryGirl.build(:post, working_hours: -1)
      expect(post.valid?).to be false
    end
  end

  context 'バリデーションテスト（working_minutes）' do

    it '作業時間が入力されていなければ無効であること' do
      post = FactoryGirl.build(:post, working_minutes: nil)
      expect(post.valid?).to be false
    end

    it '文字列の入力は無効であること' do
      post = FactoryGirl.build(:post, working_minutes: '30分')
      expect(post.valid?).to be false
    end

    it '少数点の入力は無効であること' do
      post = FactoryGirl.build(:post, working_minutes: 10.5)
      expect(post.valid?).to be false
    end

    it '61以上の数字は無効であること' do
      post = FactoryGirl.build(:post, working_minutes: 61)
      expect(post.valid?).to be false
    end

    it 'マイナスの入力は無効であること' do
      post = FactoryGirl.build(:post, working_minutes: -1)
      expect(post.valid?).to be false
    end
  end
end
