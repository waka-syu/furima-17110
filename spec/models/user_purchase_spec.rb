require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  describe '購入情報の保存' do
    before do
      @user_purchase = FactoryBot.build(:user_purchase)
    end

    context '商品購入ができる時' do
      it '必要な情報が適切に入力されていれば保存できること' do
        expect(@user_purchase).to be_valid
      end

      it 'buildingが空でも保存できること' do
        @user_purchase.building = nil
        expect(@user_purchase).to be_valid
      end
    end

    context '商品購入ができない時' do
      it 'postal_codeが空だと保存できないこと' do
        @user_purchase.postal_code = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("郵便番号を入力してください", "郵便番号はハイフン(-)を含めてください")
      end

      it 'postal_codeに(-)が無いと保存できないこと' do
        @user_purchase.postal_code = '1234567'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("郵便番号はハイフン(-)を含めてください")
      end

      it 'prefecture_idが空だと保存できないこと' do
        @user_purchase.prefecture_id = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("都道府県を入力してください", "都道府県を選んでください")
      end

      it 'prefecture_idが1だと保存できないこと' do
        @user_purchase.prefecture_id = 1
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("都道府県を選んでください")
      end

      it 'cityが空だと保存できないこと' do
        @user_purchase.city = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'address_lineが空だと保存できないこと' do
        @user_purchase.address_line = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numが空だと保存できないこと' do
        @user_purchase.phone_num = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end

      it 'phone_numが11桁以内でないと保存できないこと' do
        @user_purchase.phone_num ='090123456789'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'phone_numに(-)があると保存できないこと' do
        @user_purchase.phone_num = '090-1234-56'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'tokenが空だと保存できないこと' do
        @user_purchase.token = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("カード情報を入力してください")
      end

      it 'user_idが紐付いていないと登録できない' do
        @user_purchase.user_id = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Userを入力してください")
      end

      it 'item_idが紐付いていないと登録できない' do
        @user_purchase.item_id = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
