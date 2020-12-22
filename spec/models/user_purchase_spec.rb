require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  describe '購入情報の保存' do
    before do
      @user_purchase = FactoryBot.build(:user_purchase)
    end

    it '必要な情報が適切に入力されていれば保存できること' do
      expect(@user_purchase).to be_valid
    end

    it 'postal_codeが空だと保存できないこと' do
      @user_purchase.postal_code = nil
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
    end

    it 'postal_codeに(-)が無いと保存できないこと' do
      @user_purchase.postal_code = '1234567'
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end

    it 'prefecture_idが空だと保存できないこと' do
      @user_purchase.prefecture_id = nil
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("Prefecture can't be blank", "Prefecture Select")
    end

    it 'prefecture_idが1だと保存できないこと' do
      @user_purchase.prefecture_id = 1
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("Prefecture Select")
    end

    it 'cityが空だと保存できないこと' do
      @user_purchase.city = nil
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("City can't be blank")
    end

    it 'address_lineが空だと保存できないこと' do
      @user_purchase.address_line = nil
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("Address line can't be blank")
    end

    it 'buildingが空でも保存できること' do
      @user_purchase.building = nil
      expect(@user_purchase).to be_valid
    end

    it 'phone_numが空だと保存できないこと' do
      @user_purchase.phone_num = nil
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("Phone num can't be blank", "Phone num is invalid")
    end

    it 'phone_numが11桁以内でないと保存できないこと' do
      @user_purchase.phone_num ='090123456789'
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("Phone num is invalid")
    end

    it 'phone_numに(-)があると保存できないこと' do
      @user_purchase.phone_num = '090-1234-56'
      @user_purchase.valid?
      expect(@user_purchase.errors.full_messages).to include("Phone num is invalid")
    end
  end
end
