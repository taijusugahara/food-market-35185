require 'rails_helper'

RSpec.describe "ItemCarts", type: :system do
  before do

    @customer = FactoryBot.create(:customer)
    
    @item = FactoryBot.create(:item)
    @cart = FactoryBot.create(:cart)
  end


  context '商品をカートに追加'do
    it 'ログインした客は商品をカートに追加することができる' do
      # ログインする
      sign_in(@customer)
      # 商品詳細ページを訪れる
      visit item_path(@item)
      # 商品の数を入力する
      fill_in 'quantity', with: 2
      # カートに入れるをクリックするとItemCartモデルのカウントが１上がる
      expect{
        find('input[name="commit"]').click
      }.to change { ItemCart.count }.by(1)
      # 移動したページにはその商品の情報の他、カート空にするリンク、購入ページに行くリンクがある
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.price)
      expect(page).to have_content("カートを空にする")
      expect(page).to have_content("購入ページに行く")
    end

    it 'ログインした企業は商品をカートに追加できない' do
       # ログインする
       log_in(@item.corporation)
       # 商品詳細ページを訪れる
       visit item_path(@item)
      # 個数を入力する枠がない
       expect(page).to have_no_content("個数")
      #  カートの詳細ページへ行こうとすると客ログインページへ移動させられる
       visit cart_path(@cart)
       expect(current_path).to eq (new_customer_session_path)
       
    end

    it 'どちらにもログインしていないものは商品をカートに入れれない' do
      # トップページにいく
      visit root_path
      # 商品詳細ページを訪れる
      visit item_path(@item)
     # 個数を入力する枠がない
      expect(page).to have_no_content("個数")
      # カートの詳細ページへ行こうとすると客ログインページへ移動させられる
      visit cart_path(@cart)
      expect(current_path).to eq (new_customer_session_path)
      
   end
  end

end

RSpec.describe "ItemCarts", type: :system do
  before do

    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
    @cart = FactoryBot.create(:cart)
  end


  context 'カートに追加された商品の数を変更する'do
    it 'ログインした客はカート内商品の個数を変更することができる' do
      # ログインする
      sign_in(@customer)
      # カート詳細ページを訪れる
      visit item_path(@item)
      
      # 商品の数を入力する
      fill_in 'quantity', with: 5
      # 送信するとItemCartモデルのカウントが１上がる
      expect{
        find('input[name="commit"]').click
      }.to change { ItemCart.count }.by(1)
      # ページを移動してそこには先ほど入力した個数が表示される。そして数を変更できる
      expect(page).to have_content(5)
      expect(page).to have_content("数を変更する")
      # 数を変更するをクリックすると再度商品の詳細ページに行く
      visit item_path(@item)
      # 個数を入力する
      fill_in 'quantity', with: 10
      # 送信するとItemcartモデルのカウントは変わらず、個数が変更されている
      expect{
        find('input[name="commit"]').click
      }.to change { ItemCart.count }.by(0)
      expect(page).to have_content(10)


    end

    it 'ログインした企業はカートの商品の数を変更できない' do
      # ログインする
      log_in(@item.corporation)
      # 商品詳細ページを訪れる
      visit item_path(@item)
     # 個数を入力する枠がない
      expect(page).to have_no_content("個数")
     #  カートの詳細ページへ行こうとすると客ログインページへ移動させられる
      visit cart_path(@cart)
      expect(current_path).to eq (new_customer_session_path)
      
   end

   it 'どちらにもログインしていないものはカート内の商品の数を変更できない' do
     # トップページにいく
     visit root_path
     # 商品詳細ページを訪れる
     visit item_path(@item)
    # 個数を入力する枠がない
     expect(page).to have_no_content("個数")
     # カートの詳細ページへ行こうとすると客ログインページへ移動させられる
     visit cart_path(@cart)
     expect(current_path).to eq (new_customer_session_path)
     
  end
  end
end

RSpec.describe "ItemCarts", type: :system do
  before do

    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
    @cart = FactoryBot.create(:cart)
  end


  context 'カートに追加された商品を取り消すことができる'do
    it 'ログインした客はカート内商品の個数を変更することができる' do
      # ログインする
      sign_in(@customer)
      # カート詳細ページを訪れる
      visit item_path(@item)
      
      # 商品の数を入力する
      fill_in 'quantity', with: 5
      # 送信するとItemCartモデルのカウントが１上がる
      expect{
        find('input[name="commit"]').click
      }.to change { ItemCart.count }.by(1)
      # ページを移動してそこには先ほど入力した個数が表示される。
      expect(page).to have_content(5)
      # 取り消すをクリックするとItemCartモデルのカウントが１減り、先ほど入力した個数も消える。
      expect{
        find('input[name="commit"]').click
      }.to change { ItemCart.count }.by(-1)
      expect(page).to have_no_content(5)
    end

    it 'ログインした企業はカートの商品の数を変更できない' do
      # ログインする
      log_in(@item.corporation)
    
     #  カートの詳細ページへ行こうとすると客ログインページへ移動させられる
      visit cart_path(@cart)
      expect(current_path).to eq (new_customer_session_path)
      
   end

   it 'どちらにもログインしていないものはカート内の商品の数を変更できない' do
     # トップページにいく
     visit root_path
     
     # カートの詳細ページへ行こうとすると客ログインページへ移動させられる
     visit cart_path(@cart)
     expect(current_path).to eq (new_customer_session_path)
   end

  end
end


RSpec.describe "ItemCarts", type: :system do
  before do

    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
    @cart = FactoryBot.create(:cart)
  end


  context 'カートを空にすることができる'do
    it 'ログインした客はカートを空にすることができる' do
      # ログインする
      sign_in(@customer)
      # カート詳細ページを訪れる
      visit cart_path(@cart)
      # カートを空にするリンクがある
      expect(page).to have_content("カートを空にする")
      # カートを空にするをクリックするとそのカートは削除され、新たなカートが生まれるのでCartモデルのカウントは変わらない
      expect{
        find_link('カートを空にする').click
      }.to change { Cart.count }.by(0)
      # トップページへと移動する
      expect(current_path).to eq (root_path)
    end

    it 'ログインした企業はカートを削除できない' do
      # ログインする
      log_in(@item.corporation)
    
     #  カートの詳細ページへ行こうとすると客ログインページへ移動させられる
      visit cart_path(@cart)
      expect(current_path).to eq (new_customer_session_path)
      
   end

   it 'どちらにもログインしていないものはカートを削除できない' do
     # トップページにいく
     visit root_path
     
     # カートの詳細ページへ行こうとすると客ログインページへ移動させられる
     visit cart_path(@cart)
     expect(current_path).to eq (new_customer_session_path)
   end
  end
end