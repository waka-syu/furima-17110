class PurchasesController < ApplicationController
  def index
    @user_purchase = UserPurchase.new
    @item = Item.find(params[:item_id])
  end

  def create
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      @user_purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :prefecture_id, :city, :address_line, :building, :phone_num)
  end
end
