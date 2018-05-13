require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {FactoryGirl.build(:user) }

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(user).to be_valid
  end

  #バリデーションテスト

  context 'name test' do

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
