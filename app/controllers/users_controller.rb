class UsersController < ApplicationController
  def new
    @user= User.new
  end

  def index
    @users= User.all
  end

  def create
    @user = User.create(event_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  private
  def event_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    )
  end
end
