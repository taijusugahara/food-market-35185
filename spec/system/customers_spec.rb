require 'rails_helper'

RSpec.describe "Customers", type: :system do
  before do
    @customer = FactoryBot.build(:customer)
  end
  context 'ユーザー新規登録ができる時とできない時' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページにいく
      visit root_path
      # 新規登録ボタンがある
      expect(page).to have_content('お客様新規登録')
      # 新規登録ページにいく
      visit new_customer_registration_path
      # ユーザー登録情報を入力する
      fill_in 'customer[name]', with: @customer.name
      fill_in 'customer[email]', with: @customer.email
      fill_in 'customer[password]', with: @customer.password
      fill_in 'customer[password_confirmation]', with: @customer.password_confirmation
      fill_in 'customer[last_name]', with: @customer.last_name
      fill_in 'customer[first_name]', with: @customer.first_name
      fill_in 'customer[last_name_kana]', with: @customer.last_name_kana
      fill_in 'customer[first_name_kana]', with: @customer.first_name_kana
      select '2000', from: 'customer[birthday(1i)]'
      select '12', from: 'customer[birthday(2i)]'
      select '24', from: 'customer[birthday(3i)]'
      # 会員登録を押したらユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Customer.count }.by(1)
      # トップページに移行する
      expect(current_path).to eq (root_path)
      # ログアウトボタンが表示される。新規登録・ログインボタンは表示されない。
      expect(page).to have_content ('ログアウト')
      expect(page).to have_no_content ('お客様新規登録')
      expect(page).to have_no_content ('お客様ログイン')
    end

    it '登録情報が入力されていなければ新規登録できない' do
      # トップページにいく
      visit root_path
      # 新規登録ボタンがある
      expect(page).to have_content('お客様新規登録')
      # 新規登録ページへ移動する
      visit new_customer_registration_path
      # 登録情報を空にする
      fill_in 'customer[name]', with: ''
      fill_in 'customer[email]', with: ''
      fill_in 'customer[password]', with: ''
      fill_in 'customer[password_confirmation]', with: ''
      fill_in 'customer[last_name]', with: ''
      fill_in 'customer[first_name]', with: ''
      fill_in 'customer[last_name_kana]', with: ''
      fill_in 'customer[first_name_kana]', with: ''
      select '--', from: 'customer[birthday(1i)]'
      select '--', from: 'customer[birthday(2i)]'
      select '--', from: 'customer[birthday(3i)]'
      # 会員登録ボタンを押した時にユーザーモデルの数は変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Customer.count }.by(0)
      # ページは変わらず新規登録ページである
      expect(current_path).to eq customer_registration_path
    end

  end
end
  RSpec.describe 'ログイン', type: :system do
    before do
      @customer = FactoryBot.create(:customer)
    end
  context 'ログインができる時とできない時' do

    it 'ログインができる時'do
      # トップページにいく
      visit root_path
      # ログインボタンがある
      expect(page).to have_content('お客様ログイン')
      # ログインページにいく
      visit new_customer_session_path

      # ログイン情報を入力する
      fill_in 'customer[email]', with: @customer.email
      fill_in 'customer[password]', with: @customer.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページに移行する
      expect(current_path).to eq (root_path)
      # ログアウトボタンが表示される。新規登録・ログインボタンは表示されない。
      expect(page).to have_content ('ログアウト')
      expect(page).to have_no_content ('お客様新規登録')
      expect(page).to have_no_content ('お客様ログイン')

    end

    it 'ログインできない時'do
     # トップページにいく
     visit root_path
     # ログインボタンがある
     expect(page).to have_content('お客様ログイン')
     # ログインページにいく
     visit new_customer_session_path

     # ログイン情報を空で入力する
     fill_in 'customer[email]', with: ''
     fill_in 'customer[password]', with: ''
     # ログインボタンを押す
     find('input[name="commit"]').click
     # 変わらずログインページのまま
     expect(current_path).to eq (new_customer_session_path)
    end
  end

  
end
