require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録がうまくいくとき' do
      it "nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_kanaとfirst_kana、birth_bateが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailに@が含まれていないと登録できない" do
        @user.email = "test.test.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "password_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "passwordが５文字では登録できない" do
        @user.password = "ab123"
        @user.password_confirmation = "ab123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordが半角英数字混合でないと登録できない" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it "passwordが半角英数字混合でないと登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it "passwordとpassword_confirmationが不一致では登録できないこと" do
        @user.password = "abc123"
        @user.password_confirmation = "aaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "last_nameが空では登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name 全角文字を使用してください")
      end

      it "last_nameが全角(漢字・ひらがな・カタカナ)でないと登録できない" do
        @user.last_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
      end

      it "first_nameが空では登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name 全角文字を使用してください")
      end

      it "first_nameが全角(漢字・ひらがな・カタカナ)でないと登録できない" do
        @user.first_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
      end

      it "last_kanaが空では登録できない" do
        @user.last_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana can't be blank", "Last kana 全角カナを使用してください")
      end

      it "last_kanaが全角(カタカナ)でないと登録できない" do
        @user.last_kana = "aあ亜"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana 全角カナを使用してください")
      end

      it "first_kanaが空では登録できない" do
        @user.first_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana can't be blank", "First kana 全角カナを使用してください")
      end

      it "first_kanaが全角(カタカナ)でないと登録できない" do
        @user.first_kana = "aあ亜"
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana 全角カナを使用してください")
      end

      it "birth_dateが空では登録できない" do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
