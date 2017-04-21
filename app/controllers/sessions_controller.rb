class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid Username or Password"]
      redirect_to new_session_url
    end
  end

  def destroy
    if current_user
      logout!(current_user)
      redirect_to users_url
    else
      flash[:errors] = ["DON'T MESS WITH MY WEBSITE"]
      redirect_to users_url
    end
  end

end
