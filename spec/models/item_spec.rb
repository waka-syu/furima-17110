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
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it 'nameが空だと登録できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'textが空だと登録できない' do
        @item.text = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'state_idが空だと登録できない' do
        @item.state_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください", "商品の状態は数値で入力してください")
      end

      it 'state_idの値が１では登録できない' do
        @item.state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は1以外の値にしてください")
      end

      it 'category_idが空だと登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください", "カテゴリーは数値で入力してください")
      end

      it 'category_idの値が１では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
      end

      it 'fee_idが空だと登録できない' do
        @item.fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください", "配送料の負担は数値で入力してください")
      end

      it 'fee_idの値が１では登録できない' do
        @item.fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は1以外の値にしてください")
      end

      it 'prefecture_idが空だと登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください", "発送元の地域は数値で入力してください")
      end

      it 'prefecture_idの値が１では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
      end

      it 'delivery_date_idが空だと登録できない' do
        @item.delivery_date_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください", "発送までの日数は数値で入力してください")
      end

      it 'delivery_date_idの値が１では登録できない' do
        @item.delivery_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は1以外の値にしてください")
      end

      it 'valueが空だと登録できない' do
        @item.value = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は数値で入力してください", "価格は不正な値です")
      end

      it 'valueの値が300より小さいと登録できない' do
        @item.value = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
      end

      it 'valueの値が9,999,999より大きいと登録できない' do
        @item.value = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
      end

      it 'valueが半角数字でないと登録できない' do
        @item.value = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end

      it 'userが紐付いていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
