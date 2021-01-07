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
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it "emailに@が含まれていないと登録できない" do
        @user.email = "test.test.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end

      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end

      it "passwordが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードには半角の英数字を含めて設定してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end

      it "password_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it "passwordが５文字では登録できない" do
        @user.password = "ab123"
        @user.password_confirmation = "ab123"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it "passwordが半角英数字混合でないと登録できない" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角の英数字を含めて設定してください")
      end

      it "passwordが半角英数字混合でないと登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角の英数字を含めて設定してください")
      end

      it "passwordが全角英数混合では登録できない" do
        @user.password = "ＡＡＡ１１１"
        @user.password_confirmation = "ＡＡＡ１１１"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角の英数字を含めて設定してください")
      end

      it "passwordとpassword_confirmationが不一致では登録できないこと" do
        @user.password = "abc123"
        @user.password_confirmation = "aaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it "last_nameが空では登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)を入力してください", "お名前(姓)全角文字を使用してください")
      end

      it "last_nameが全角(漢字・ひらがな・カタカナ)でないと登録できない" do
        @user.last_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)全角文字を使用してください")
      end

      it "first_nameが空では登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)を入力してください", "お名前(名)全角文字を使用してください")
      end

      it "first_nameが全角(漢字・ひらがな・カタカナ)でないと登録できない" do
        @user.first_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)全角文字を使用してください")
      end

      it "last_kanaが空では登録できない" do
        @user.last_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(姓)を入力してください", "フリガナ(姓)全角カナを使用してください")
      end

      it "last_kanaが全角(カタカナ)でないと登録できない" do
        @user.last_kana = "aあ亜"
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(姓)全角カナを使用してください")
      end

      it "first_kanaが空では登録できない" do
        @user.first_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(名)を入力してください", "フリガナ(名)全角カナを使用してください")
      end

      it "first_kanaが全角(カタカナ)でないと登録できない" do
        @user.first_kana = "aあ亜"
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(名)全角カナを使用してください")
      end

      it "birth_dateが空では登録できない" do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
