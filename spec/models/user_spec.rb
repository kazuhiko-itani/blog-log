require 'rails_helper'

RSpec.describe User, type: :model do

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
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

  context 'email test' do

    # アドレスがなければ無効であること
    it 'is invalid without a email address' do
      user = FactoryGirl.build(:user, email: nil)
      expect(user.valid?).to be false
    end

    # アドレスが長すぎると無効であること
    it 'is invalid with too long email address' do
      user = FactoryGirl.build(:user, email: 'a' * 256)
      expect(user.valid?).to be false
    end

    # 重複したアドレスは無効であること
    it 'is invalid with a dupicate email address' do
      FactoryGirl.create(:user, email: 'test@gmail.com')
      user = FactoryGirl.build(:user, email: 'test@gmail.com'.upcase)
      expect(user.valid?).to be false
    end

    # 有効な形式のアドレスパターン
    it 'accepts valid address' do
      user = FactoryGirl.build(:user)
      valid_addresses = %w[user@gmail.com sakana@yahoo.co.jp
                         test.test@gmail.com yamada+konan@docomo.ne.jp]
      valid_addresses.each do |address|
        user.email = address
        expect(user.valid?).to be true
      end
    end

    # 無効な形式のアドレスパターン
    it 'does not accept invalid address' do
      user = FactoryGirl.build(:user)
      invalid_addresses = %w[user@gmail,com testmode@yahoo.com@gmail.com
                                  heyheyhey@yahoo.com. sakana_rb.com]
      invalid_addresses.each do |address|
        user.email = address
        expect(user.valid?).to be false
      end
    end

    # アドレスは小文字で保存されること
    it 'has a lower-address' do
      user = FactoryGirl.build(:user, email: 'TEST@gmail.com')
      user.save
      expect(user.reload.email).to eq 'test@gmail.com'
    end
  end

  context 'password test' do

    #パスワードがなければ無効であること
    it 'is invalid without a password' do
      user = FactoryGirl.build(:user,
        password: nil,
        password_confirmation: nil
      )
    expect(user.valid?).to be false
    end

    # 短すぎるパスワードは無効であること
    it 'is invalid with too short password' do
      user = FactoryGirl.build(:user,
        password: 'a' * 4,
        password_confirmation: 'a' * 4
      )
      expect(user.valid?).to be false
    end
  end
end
