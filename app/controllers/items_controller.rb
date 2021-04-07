class ItemsController < ApplicationController
  def index
    @items = Item.includes(:corporation).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create 
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :category_id, 
                                :price, :number).merge(corporation_id: current_corporation.id)
  end
end
