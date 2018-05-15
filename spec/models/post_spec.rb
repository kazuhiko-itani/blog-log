require 'rails_helper'

RSpec.describe Post, type: :model do

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    post = FactoryGirl.create(:post)
    expect(post).to be_valid
  end

  # 最新の投稿順にデータが抽出されること
  it 'order is most recent' do
    post1 = FactoryGirl.create(:post, :date_yesterday)
    post2 = FactoryGirl.create(:post)
    post3 = FactoryGirl.create(:post, :date_tomorrow)
    expect(Post.first).to eq post3
  end

  # バリデーションテスト

  context 'date' do

    # 日付が入力されていなければ無効であること
    it 'is invalid without Date' do
      post = FactoryGirl.build(:post, date: nil)
      expect(post.valid?).to be false
    end

    # 1人のユーザーは投稿日が同じpostを持てないこと
    it 'is invalid with same date on a user' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:post, user: user)
      post = FactoryGirl.build(:post, user: user)
      expect(post.valid?).to be false
    end

    # 異なるユーザーであれば、投稿日が同じpostを持てること
    it 'is valid with same date per user' do
      FactoryGirl.create(:post, date: '2018-05-05')
      other_user = FactoryGirl.create(:user)
      post = FactoryGirl.build(:post, user: other_user, date: '2018-05-05')
      expect(post.valid?).to be true
    end
  end

  context 'memo' do

    # 255文字を超えるメモを持つ投稿は無効であること
    it 'is invalid with too long memo' do
      post = FactoryGirl.build(:post, memo: 'a' * 256)
      expect(post.valid?).to be false
    end
  end

  context 'working_total' do

    # 作業時間が入力されていなければ無効であること
    it 'is invalid when working_total is blank' do
      post = FactoryGirl.build(:post, working_total: nil)
      expect(post.valid?).to be false
    end
  end

  context 'working_hours' do

    # 作業時間が入力されていなければ無効であること
    it 'is invalid when working_hours is blank' do
      post = FactoryGirl.build(:post, working_hours: nil)
      expect(post.valid?).to be false
    end

    # 文字列の入力は無効であること
    it 'is invalid with string' do
      post = FactoryGirl.build(:post, working_hours: '1時間')
      expect(post.valid?).to be false
    end

    # 少数点の入力は無効であること
    it 'is invalid with float' do
      post = FactoryGirl.build(:post, working_hours: 1.5)
      expect(post.valid?).to be false
    end

    # 24以上の数字は無効であること
    it 'is invalid over 61' do
      post = FactoryGirl.build(:post, working_hours: 24)
      expect(post.valid?).to be false
    end

    # マイナスの入力は無効であること
    it 'is invalid with minus' do
      post = FactoryGirl.build(:post, working_hours: -1)
      expect(post.valid?).to be false
    end
  end

  context 'working_minutes' do

    # 作業時間が入力されていなければ無効であること
    it 'is invalid when working_minutes is blank' do
      post = FactoryGirl.build(:post, working_minutes: nil)
      expect(post.valid?).to be false
    end

    # 文字列の入力は無効であること
    it 'is invalid with string' do
      post = FactoryGirl.build(:post, working_minutes: '30分')
      expect(post.valid?).to be false
    end

    # 少数点の入力は無効であること
    it 'is invalid with float' do
      post = FactoryGirl.build(:post, working_minutes: 10.5)
      expect(post.valid?).to be false
    end

    # 61以上の数字は無効であること
    it 'is invalid over 61' do
      post = FactoryGirl.build(:post, working_minutes: 61)
      expect(post.valid?).to be false
    end

    # マイナスの入力は無効であること
    it 'is invalid with minus' do
      post = FactoryGirl.build(:post, working_minutes: -1)
      expect(post.valid?).to be false
    end
  end
end
