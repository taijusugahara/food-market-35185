require 'rails_helper'

RSpec.describe ItemCart, type: :model do
  before do
    @item_cart = FactoryBot.build(:item_cart)
  end

  describe '商品カート' do
    context '商品をカートに入れれる時' do
      it '必要な情報が全てあれば商品をカートに入れることができる' do
        expect(@item_cart).to be_valid
      end
    end

    context '商品をカートに入れれない時' do
      it 'quantityが空であれば商品をカートに入れれない' do
        @item_cart.quantity = ''
        @item_cart.valid?
        expect(@item_cart.errors.full_messages).to include('Quantity is not a number')
      end

      it 'quantityが0以下であれば商品をカートに入れれない' do
        @item_cart.quantity = 0
        @item_cart.valid?
        expect(@item_cart.errors.full_messages).to include('Quantity must be greater than or equal to 1')
      end

      it 'itemが結びついていなければ商品をカートに入れれない' do
        @item_cart.item = nil
        @item_cart.valid?
        expect(@item_cart.errors.full_messages).to include('Item must exist')
      end

      it 'cartが結びついていなければ商品をカートに入れれない' do
        @item_cart.cart = nil
        @item_cart.valid?
        expect(@item_cart.errors.full_messages).to include('Cart must exist')
      end
    end
  end
end
