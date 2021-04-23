class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :move_to_cart_show
  def index
   @cart = current_cart
   @items= @cart.item_carts
   @order = OrderAddress.new
   total_price
  end

  def create
    @cart = current_cart
    @order = OrderAddress.new(order_params)
    total_price
    
    if@order.valid? 
      pay_item
      @order.save
      session[:cart_id] = nil
      redirect_to root_path
    else
      @cart = current_cart
      @items= @cart.item_carts
      render :index
    end
  end


  private
  def order_params
    
    params.require(:order_address).permit(:postal_code, :prefecture_id, :town, :residence, :building, :tell_number).merge(customer_id: current_customer.id, cart_id: @cart.id, token: params[:token]
    )
  end 

  def total_price
    @items= @cart.item_carts

    sum = 0 
   @items.each do |item|  
   item.item.price * item.quantity 
   sum += item.item.price * item.quantity 
    @sum = sum
   end
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @sum,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_cart_show
    @cart = current_cart
    redirect_to cart_path(@cart) unless @cart.item_carts.length > 0
  end
end
