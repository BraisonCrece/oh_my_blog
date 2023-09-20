class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def show
    @articles = @user.articles
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :picture)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
