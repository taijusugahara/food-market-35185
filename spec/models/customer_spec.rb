require 'rails_helper'

RSpec.describe Customer, type: :model do
  before do
    @customer = FactoryBot.build(:customer)
  end


describe 'ユーザー新規登録' do
  context '新規登録できる時' do
    it '全て記述されていれば登録できる' do
     expect(@customer).to be_valid
    end
  end
  
  context '新規登録できない時' do
    it 'nameが空だと登録できない' do
      @customer.name = ''
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Name can't be blank")
    end
    it 'emailが空だと登録できない' do
      @customer.email = ''
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Email can't be blank")
    end
    it '同じemailは登録できない' do
      @customer.save
      another_customer = FactoryBot.build(:customer)
      another_customer.email = @customer.email
      another_customer.valid?
      expect(another_customer.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailに@が記述されていないと登録できない' do
      @customer.email = '111'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空だと登録できない' do
      @customer.password = ''
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字未満だと登録できない' do
      @customer.password = '1a111'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが数字だけでは登録できない' do
      @customer.password = '111111'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('Password is invalid')
    end

    it 'passwordが英語だけでは登録できない' do
      @customer.password = 'abcdef'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('Password is invalid')
    end

    it 'passwordが半角英数以外の文字を含んでいたら登録できない' do
      @customer.password = '1aアイウエ'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('Password is invalid')
    end

    it 'passwordを２回入力しないと登録できない' do
      @customer.password = '1a1111'
      @customer.password_confirmation = ''
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'passwordとpassword_confirmationが一致しないと登録できない' do
      @customer.password = '1a1111'
      @customer.password_confirmation = '2b2222'
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'last_nameが記述されていないと登録できない' do
      @customer.last_name = ''
      @customer.first_name = '太郎'
      @customer.valid?

      expect(@customer.errors.full_messages).to include("Last name can't be blank")
    end

    it 'first_nameが記述されていないと登録できない' do
      @customer.last_name = '山田'
      @customer.first_name = ''
      @customer.valid?
      expect(@customer.errors.full_messages).to include("First name can't be blank")
    end

    it 'last_nameは、全角（漢字・ひらがな・カタカナ）で記述されていないと登録できない' do
      @customer.last_name = 'abc'
      @customer.first_name = '太郎'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('Last name is invalid')
    end

    it 'first_nameは、全角（漢字・ひらがな・カタカナ）で記述されていないと登録できない' do
      @customer.last_name = '山田'
      @customer.first_name = 'abc'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('First name is invalid')
    end

    it 'last_name_kanaが記述されていないと登録できない' do
      @customer.last_name_kana = ''
      @customer.first_name_kana = 'タロウ'
      @customer.valid?

      expect(@customer.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'first_name_kanaが記述されていないと登録できない' do
      @customer.last_name_kana = 'ヤマダ'
      @customer.first_name_kana = ''
      @customer.valid?
      expect(@customer.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'last_name_kanaがカタカナで記述されていないと登録できない' do
      @customer.last_name_kana = '山田'
      @customer.first_name_kana = 'タロウ'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('Last name kana is invalid')
    end

    it 'first_name_kanaがカタカナで記述されていないと登録できない' do
      @customer.last_name_kana = 'ヤマダ'
      @customer.first_name_kana = '太郎'
      @customer.valid?
      expect(@customer.errors.full_messages).to include('First name kana is invalid')
    end

    it 'birthdayが空だと登録できない' do
      @customer.birthday = ''
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
end