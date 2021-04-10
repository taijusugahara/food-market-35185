class CartsController < ApplicationController

  def new

    @items = Item.all
    @cart = Cart.new

  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      redirect_to root_path
    else
      render
    end

  end


  private
  def cart_params
    params.require(:cart).permit(:quantity, item_ids: []).merge(customer_id: current_customer.id)
    
  
  end
end
