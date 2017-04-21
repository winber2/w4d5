class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def index
    @users = User.all
    render :index
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["CAN'T CREATE INVALID USER MAN"]
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def update
    @user = User.find_by(id: params[:id])

    if same_password?(@user) && @user.update_attributes(user_params)
      render :show
    else
      flash[:errors] = ["WRONG PASSWORD YA DUNCE"]
      redirect_to edit_user_url(@user)
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def same_password?(user)
    return nil unless user
    user.is_password?(params[:user][:old_pass])
  end

end
