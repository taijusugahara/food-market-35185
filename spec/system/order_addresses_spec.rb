require 'rails_helper'

RSpec.describe 'OrderAddresses', type: :system do
  before do
    @item_cart = FactoryBot.create(:item_cart)
    @customer = FactoryBot.create(:customer)
    @cart = FactoryBot.create(:cart)
  end

  context 'カート内商品を購入' do
    it 'ログインした客はカートに入っている商品を購入できる' do
      # ログインする
      sign_in(@customer)
      # 商品詳細ページを訪れる
      visit item_path(@item_cart.item)
      # 個数を入力する
      fill_in 'quantity', with: 2
      # カートに入れるをクリックするとItemCartモデルのカウントが１上がる

      # 送信するとカートの詳細ページに行く
      find('input[name="commit"]').click

      expect(page).to have_content('購入ページに行く')
      # 購入ページに行く
      visit cart_orders_path(@item_cart.cart)
      # 先ほど入力した商品の情報が出る
      expect(page).to have_content('購入内容の確認')
      expect(page).to have_content(@item_cart.item.price)
      expect(page).to have_content(@item_cart.item.name)

      # 情報を入力する
      fill_in 'order_address[number]', with: '4012888888881881'
      fill_in 'order_address[month]', with: '12'
      fill_in 'order_address[year]', with: '23'
      fill_in 'order_address[cvc]', with: '123'
      fill_in 'order_address[postal_code]', with: '123-4567'
      select '北海道', from: 'order_address[prefecture_id]'
      fill_in 'order_address[town]', with: '横浜'
      fill_in 'order_address[residence]', with: '横浜'
      fill_in 'order_address[tell_number]', with: '1234567890'
      # 送信するとOrderモデルとAddressモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
        sleep 2
      end.to change { Order.count & Address.count }.by(1)
      # トップページへと移行する
      expect(current_path).to eq(root_path)
    end

    it 'カートに商品が入っていなければ購入ページに行けない' do
      # ログインする
      sign_in(@customer)
      # カートの詳細ページを訪れる
      visit cart_path(@item_cart.cart)
      expect(page).to have_content('購入ページに行く')
      # 購入ページに行こうとするとカート詳細ページに戻される
      visit cart_orders_path(@item_cart.cart)
      expect(page).to have_content('購入ページに行く')
    end

    it 'ログインした企業は商品を購入できない' do
      # ログインする
      log_in(@item_cart.item.corporation)
      # 購入ページを訪れようとすると客ログインページへと移動させられる
      visit cart_orders_path(@item_cart.cart)
      expect(current_path).to eq(new_customer_session_path)
    end

    it 'どちらにもログインしていないものは購入ページにいけない' do
      # ログインする
      visit root_path
      # 購入ページを訪れようとすると客ログインページへと移動させられる
      visit cart_orders_path(@item_cart.cart)
      expect(current_path).to eq(new_customer_session_path)
    end
  end
end
