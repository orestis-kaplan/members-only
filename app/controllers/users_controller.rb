class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:success] = "User created successfully"
      redirect_to posts_path
    else
      flash[:danger] = "Could not save client"
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
