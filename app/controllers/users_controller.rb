class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @items = @user.items.order("created_at DESC")
    @purchases = Purchase.includes(:item)
    @profile = Profile.find_by(user_id: params[:id])
  end
end
