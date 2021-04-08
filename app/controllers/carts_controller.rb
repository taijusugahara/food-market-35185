class CartsController < ApplicationController
  before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]
  def show
    @cart_items = current_cart.item_carts
  end

  def add_item
    
    if @cart_item.blank?
      @cart_item = current_cart.item_carts.build(item_id: params[:item_id])
    end

    @cart_item.quantity += params[:quantity].to_i
    @cart_item.save
    @cart = session[:cart_id]
    redirect_to cart_path(@cart)
  end

  def update_item
    @cart_item.update(quantity: params[:quantity].to_i)
    redirect_to ''
  end

  def delete_item
    @cart_item.destroy
    redirect_to ''
  end

  private

  def setup_cart_item!
    @cart_item = current_cart.item_carts.find_by(item_id: params[:item_id])
  end
end
