require 'rails_helper'

RSpec.describe "Corporations", type: :system do
  before do
    @corporation = FactoryBot.create(:corporation)
  end
  context '企業がログインできる時とできない時' do

    it '指定のemailとpasswordを使えばログインができる'do
      # トップページにいく
      visit root_path
      # ログインボタンがある
      expect(page).to have_content('企業様ログイン')
      # ログインページにいく
      visit new_corporation_session_path

      # ログイン情報を入力する
        fill_in 'corporation[email]', with: @corporation.email
        fill_in 'corporation[password]', with: @corporation.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページに移行する
      expect(current_path).to eq (root_path)
      # ログアウトボタンが表示される。新規登録・ログインボタンは表示されない。
      expect(page).to have_content ('ログアウト')
      expect(page).to have_no_content ('企業様ログイン')

    end

    it '指定のemailとpassword以外を入力するとログインできない' do
      # トップページにいく
      visit root_path
      # ログインボタンがある
      expect(page).to have_content('企業様ログイン')
      # ログインページにいく
      visit new_corporation_session_path

      # ログイン情報を入力する
        fill_in 'corporation[email]', with: '@corporation'
        fill_in 'corporation[password]', with: '1234abcd'
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ページ変わらずログインできない
      expect(current_path).to eq (new_corporation_session_path)
    end
  end
end
