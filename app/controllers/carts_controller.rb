
class CartsController < ApplicationController
  before_action :setup_cart_item!, only: [:add_item, :delete_item]
  def show
    @cart_items = current_cart.item_carts
    @cart = current_cart 
  end

  def add_item
    
    if @cart_item.blank?
      @cart_item = current_cart.item_carts.build(item_id: params[:item_id])
    end

    @cart_item.quantity = params[:quantity].to_i
    @cart_item.save
    # redirect_to current_cart
     @cart = session[:cart_id]
    redirect_to carts_path(@cart)
  end

  

  def delete_item
    @cart_item.destroy
    @cart = session[:cart_id]
    redirect_to carts_path(@cart)
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    redirect_to root_path
  end

  private
  def setup_cart_item!
    @cart_item = current_cart.item_carts.find_by(item_id:params[:item_id])
  end
end

