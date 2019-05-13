# SessionsController class
class SessionsController < ApplicationController

  include SessionsHelper

  def new
  end

  def create
   user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      login(user)
      remember(user)
      redirect_to posts_path
    else
      flash[:danger] = 'Wrong credentials'
      render 'new'
    end
  end

  def destroy
    logout(@current_user)
    forget(@current_user)
    redirect_to login_path
  end
end
