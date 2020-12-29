class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update]
  before_action :set_user, only: [:new, :create, :edit, :update]

  def new
    @profile = Profile.new
    if current_user.id != @user.id
      redirect_to root_path
    end
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to user_path(@profile.user.id)
    else
      render :new
    end
  end

  def edit
    if current_user.id != @profile.user.id
      redirect_to root_path
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(@profile.user.id)
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def profile_params
    params.require(:profile).permit(:status_message, :prefecture_id, :gender_id).merge(user_id: current_user.id)
  end
end
