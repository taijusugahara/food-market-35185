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
    @item_cart = Item.find(params[:id])
    @cart = current_cart
  end
  

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else

      render :edit

    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path
  
  end
  private
  def item_params
    params.require(:item).permit(:image, :name, :category_id, 
                                :price).merge(corporation_id: current_corporation.id)
  end

end
