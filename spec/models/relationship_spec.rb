require 'rails_helper'

RSpec.describe Relationship, type: :model do

  it '有効なファクトリを持つこと' do
    relationship = FactoryGirl.build(:relationship)
    expect(relationship.valid?).to be true
  end

  context 'バリデーションテスト(follower_id)' do

    it 'follower_idがなければ無効であること' do
      relationship = FactoryGirl.build(:relationship, follower_id: nil)
      expect(relationship.valid?).to be false
    end
  end

  context 'バリデーションテスト(followed_id)' do

    it 'followed_idがなければ無効であること' do
      relationship = FactoryGirl.build(:relationship, followed_id: nil)
      expect(relationship.valid?).to be false
    end
  end
end
