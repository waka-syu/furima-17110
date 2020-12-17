require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '出品がうまくいくとき' do
      it 'imageとname、textとstate_id、category_idとfee_id、prefecture_idとdelivery_date_id、valueが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかないとき' do
      it 'imageが空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空だと登録できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'textが空だと登録できない' do
        @item.text = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end

      it 'state_idが空だと登録できない' do
        @item.state_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("State can't be blank", "State is not a number")
      end

      it 'state_idの値が１では登録できない' do
        @item.state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("State must be other than 1")
      end

      it 'category_idが空だと登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
      end

      it 'category_idの値が１では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it 'fee_idが空だと登録できない' do
        @item.fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Fee can't be blank", "Fee is not a number")
      end

      it 'fee_idの値が１では登録できない' do
        @item.fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Fee must be other than 1")
      end

      it 'prefecture_idが空だと登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
      end

      it 'prefecture_idの値が１では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'delivery_date_idが空だと登録できない' do
        @item.delivery_date_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery date can't be blank", "Delivery date is not a number")
      end
      it 'delivery_date_idの値が１では登録できない' do
        @item.delivery_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery date must be other than 1")
      end

      it 'valueが空だと登録できない' do
        @item.value = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Value can't be blank")
      end

      it 'valueの値が300より小さいと登録できない' do
        @item.value = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Value must be greater than or equal to 300")
      end

      it 'valueの値が9,999,999より大きいと登録できない' do
        @item.value = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Value must be less than or equal to 9999999")
      end

      it 'valueが半角数字でないと登録できない' do
        @item.value = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Value is not a number")
      end

      it 'userが紐付いていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
