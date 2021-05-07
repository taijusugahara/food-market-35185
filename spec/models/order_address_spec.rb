require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    customer = FactoryBot.create(:customer)
    cart = FactoryBot.create(:cart)
    @order_address = FactoryBot.build(:order_address, customer_id: customer.id, cart_id: cart.id)
  end

  context '商品購入ができる時' do
    it '全ての情報が入力されていれば購入できる' do
      expect(@order_address).to be_valid
    end

    it 'buildingが空でも購入できる' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end
  context '商品購入できない時' do
    it 'tokenが空だと購入できない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'postal_codeが空だと購入できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeはハイフンがないと購入できない' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end

    it 'postal_codeは全角入力だとと購入できない' do
      @order_address.postal_code = '１２３４−５６７'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end

    it 'prefecture_idが1だと購入できない' do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it 'townが空だと購入できない' do
      @order_address.town = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Town can't be blank")
    end

    it 'residenceが空だと購入できない' do
      @order_address.residence = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Residence can't be blank")
    end

    it 'tell_numberが空だと購入できない' do
      @order_address.tell_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Tell number can't be blank")
    end

    it 'tell_numberが10桁未満だと購入できない' do
      @order_address.tell_number = '123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Tell number is invalid')
    end

    it 'tell_numberが12桁以上だと購入できない' do
      @order_address.tell_number = '012345678912'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Tell number is invalid')
    end

    it 'tell_numberが英数字混合だと購入できない' do
      @order_address.tell_number = '0123456abcd'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Tell number is invalid')
    end

    it 'tell_numberが全角入力だと購入できない' do
      @order_address.tell_number = '０１２３４５６７８９０'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Tell number is invalid')
    end

    it 'customer_idが空だと購入できない' do
      @order_address.customer_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Customer can't be blank")
    end

    it 'cart_idが空だと購入できない' do
      @order_address.cart_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Cart can't be blank")
    end
  end
end
