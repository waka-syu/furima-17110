class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    @user_purchase = UserPurchase.new
  end

  def create
    binding.pry
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      pay_item
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
    params.require(:user_purchase).permit(:postal_code, :prefecture_id, :city, :address_line, :building, :phone_num).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_cb3df47f44bf9d0db65b08a7"
    Payjp::Charge.create(
      amount: @item.value,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
