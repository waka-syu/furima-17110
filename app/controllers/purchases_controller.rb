class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:index, :create]

  def index
    @user_purchase = UserPurchase.new
    @purchase = Purchase.find_by(item_id: @item.id)
    if @purchase.present?
      redirect_to root_path
    elsif current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def create
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      pay_item
      @user_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :prefecture_id, :city, :address_line, :building, :phone_num).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.value,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
