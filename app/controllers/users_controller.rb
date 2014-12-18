class UsersController < ApplicationController
  def new
    @user= User.new
  end

  def index
    @users= User.all
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to users_path
      flash[:notice]="User successfully created."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user= User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
      flash[:notice] = "User has been successfully updated."
    else
      render :edit
    end
  end

  def show
    @user=User.find(params[:id])
  end

  def destroy
    @user= User.find(params[:id])
    @user.destroy
    redirect_to users_path
    flash[:notice]= "User has been successfully deleted."
  end

  private
  def user_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :password,
    :password_confirmation
    )
  end
end
