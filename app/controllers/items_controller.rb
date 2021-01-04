class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_purchases, only: [:index, :search]
  before_action :search_item, only: [:index, :search]

  def index
    @items = Item.includes(:user).order("created_at DESC")
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
    @purchase = Purchase.find_by(item_id: params[:id])
  end

  def edit
    @purchase = Purchase.find_by(item_id: @item.id)
    if current_user.id != @item.user.id
      redirect_to action: :index
    elsif @purchase.present?
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user.id
      @item.destroy
    end
    redirect_to root_path
  end

  def search
    @items = @i.result(distinct: true).order(created_at: "DESC").includes(:user)
  end

  private

  def search_item
    @i = Item.ransack(params[:q])
  end

  def set_purchases
    @purchases = Purchase.includes(:item)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :state_id, :fee_id, :prefecture_id, :delivery_date_id, :value).merge(user_id: current_user.id)
  end
end
