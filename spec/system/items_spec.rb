require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    @corporation = FactoryBot.create(:corporation)
    @customer = FactoryBot.create(:customer)
  end

  context '商品を出品'do
    it 'ログインした企業は商品を出品できる' do
      # ログインする
      log_in(@corporation)
      # 出品するボタンがある
      expect(page).to have_content "出品する"
      # 出品ページに行く
      visit new_item_path
      # 情報を入力する
      image_path = Rails.root.join('public/images/sample1.png')
      attach_file('item[image]', image_path, make_visible: true)
      fill_in 'item[name]', with: "トマト"
      select '野菜', from: 'item[category_id]'
      fill_in 'item[price]', with: 100
      # 送信するとItemモデルのカウントが１上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページに移動する
      expect(current_path).to eq (root_path)
      # トップページには先ほど入力したimage,name,priceが表示されている
      expect(page).to have_selector('img')
      expect(page).to have_content "トマト"
      expect(page).to have_content 100
    end
    it 'ログインした客は商品を出品できない' do
      # ログインする
      sign_in(@customer)
      # 出品するボタンがない
      expect(page).to have_no_content "出品する"
      # 出品ページに行く
      visit new_item_path
      # 企業ログインページへと移動させられる
      expect(current_path).to eq (new_corporation_session_path)


    end

    it 'どちらにもログインしていないものは出品できない' do
    #  トップページにいく
      visit root_path
      # 出品するボタンがない
      expect(page).to have_no_content "出品する"
      # 出品ページに行く
      visit new_item_path
      # 企業ログインページへと移動させられる
      expect(current_path).to eq (new_corporation_session_path)

    end
  end

end

RSpec.describe "Items", type: :system do
  before do
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
  end

  context '商品の詳細'do
    it 'ログインした企業は商品の詳細ページに行くことができ、編集・削除のリンクがある' do
      # ログインする
      log_in(@item.corporation)
      # 詳細ページにいく
      visit item_path(@item)
      # 商品の編集リンク、削除リンクがある
      expect(page).to have_content("商品の編集")
      expect(page).to have_content("削除")
      expect(page).to have_no_content("個数")
    end

    it 'ログインした客は商品の詳細ページに行くことができ、個数を選択できカートに入れれる' do
      # ログインする
      sign_in(@customer)
      # 詳細ページにいく
      visit item_path(@item)
      # カートに入れるリンクがある
      
      expect(page).to have_content("個数")
      expect(page).to have_no_content("商品の編集")
      expect(page).to have_no_content("削除")
    end

    it 'どちらにもログインしていないものは商品の詳細ページにいけるが、編集・削除・個数を選択してカートに入れることはできない' do
      # トップページ
      visit root_path
      # 詳細ページにいく
      visit item_path(@item)
      # 編集・削除・個数は表示されない
      expect(page).to have_no_content("個数")
      expect(page).to have_no_content("商品の編集")
      expect(page).to have_no_content("削除")

    end

  end
end

RSpec.describe "Items", type: :system do
  before do
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
  end

  context '商品の編集'do
    it 'ログインした企業は商品の編集ができる' do
      # ログインする
      log_in(@item.corporation)
      # 詳細ページにいく
      visit item_path(@item)
      # 編集リンクがある
      expect(page).to have_content("商品の編集")
      # 編集ページを訪れる
      visit edit_item_path(@item)
      # 情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('item[image]', image_path, make_visible: true)
      fill_in 'item[name]', with: "なす"
      select '野菜', from: 'item[category_id]'
      fill_in 'item[price]', with: 80
      # 送信する
        find('input[name="commit"]').click
      # 商品詳細ページに移動する
        expect(current_path).to eq (item_path(@item))
        expect(page).to have_selector('img')
        expect(page).to have_content "なす"
        expect(page).to have_content "野菜"
        expect(page).to have_content 80
    end

    it 'ログインした客は商品を編集できない' do
      # ログインする
      sign_in(@customer)
      # 詳細ページにいく
      visit item_path(@item)
      # 編集リンクがない
      expect(page).to have_no_content("商品の編集")
      # 編集ページを訪れる
      visit edit_item_path(@item)
      # 企業ログインページへと移動させられる
      expect(current_path).to eq(new_corporation_session_path)
    end

    it 'どちらにもログインしてないものは商品を編集できない' do
      # トップページにいく
      visit root_path
      # 詳細ページにいく
      visit item_path(@item)
      # 編集リンクがない
      expect(page).to have_no_content("商品の編集")
      # 編集ページを訪れる
      visit edit_item_path(@item)
      # 企業ログインページへと移動させられる
      expect(current_path).to eq(new_corporation_session_path)
    end

  end
end

RSpec.describe "Items", type: :system do
  before do
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
  end

  context '商品の削除'do
    it 'ログインした企業は商品の削除ができる' do
      # ログインする
      log_in(@item.corporation)
      # 詳細ページにいく
      visit item_path(@item)
      # 商品削除リンクがある
      expect(page).to have_content("削除")
      # 削除を押すとItemモデルのカウントが1減りトップページに戻る
      expect{
        find_link('削除', href: item_path(@item)).click
      }.to change { Item.count }.by(-1)
      expect(current_path).to eq (root_path)
    end

    it 'ログインした客は商品を削除できない' do
      # ログインする
      sign_in(@customer)
      # 詳細ページにいく
      visit item_path(@item)
      # 商品削除リンクがない
      expect(page).to have_no_content("削除")
    end

    it 'どちらにもログインしていないものは商品を削除できない' do
      # トップページにいく
      visit root_path
      # 詳細ページにいく
      visit item_path(@item)
      # 商品削除リンクがない
      expect(page).to have_no_content("削除")
    end

  end
end

      


