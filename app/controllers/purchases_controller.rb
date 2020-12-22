class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    @user_purchase = UserPurchase.new
  end

  def create
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      @user_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  private

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :prefecture_id, :city, :address_line, :building, :phone_num)
  end
end
