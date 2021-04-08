class ItemsController < ApplicationController
  def index
    @items = Item.includes(:corporation).order('created_at DESC')
    @vegetable = Item.where(category_id: 2)
    @meat = Item.where(category_id: 3)
    @fish = Item.where(category_id: 4)
    @fruit = Item.where(category_id: 5)
    @milk = Item.where(category_id: 6)
    @snack = Item.where(category_id: 7)
    @souzai = Item.where(category_id: 8)
    @drink = Item.where(category_id: 9)
    @other = Item.where(category_id: 10)
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

  def show
    @item = Item.find(params[:id])
  end
  private

  def item_params
    params.require(:item).permit(:image, :name, :category_id, 
                                :price, :number).merge(corporation_id: current_corporation.id)
  end
end
