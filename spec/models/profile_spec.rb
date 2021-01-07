require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'プロフィール登録' do
    before do
      @profile = FactoryBot.build(:profile)
    end
  
    context 'プロフィール登録がうまくいくとき' do
      it 'status_messageとprefecture_idとgender_idが存在すれば登録できる' do
        expect(@profile).to be_valid
      end

      it 'status_messageが存在しなくても登録できる' do
        @profile.status_message = nil
        expect(@profile).to be_valid
      end
    end
    context 'プロフィール登録がうまくいかないとき' do
      it 'prefecture_idが空だと登録できない' do
        @profile.prefecture_id = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include("登録地域を入力してください", "登録地域は数値で入力してください")
      end

      it 'prefecture_idの値が１では登録できない' do
        @profile.prefecture_id = 1
        @profile.valid?
        expect(@profile.errors.full_messages).to include("登録地域は1以外の値にしてください")
      end

      it 'gender_idが空だと登録できない' do
        @profile.gender_id = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include("性別を入力してください", "性別は数値で入力してください")
      end

      it 'gender_idの値が１では登録できない' do
        @profile.gender_id = 1
        @profile.valid?
        expect(@profile.errors.full_messages).to include("性別は1以外の値にしてください")
      end
    end
  end
end
