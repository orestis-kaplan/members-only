module SessionsHelper

  def login(user)
    session[:id] = user.id
    flash[:success] = "#{user.name} logged in"
  end

  def logout(user)
    session.delete :id
    user = nil
  end

  def remember(user)
    cookies.permanent.signed[:id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    if session[:id]
      @current_user ||= User.find_by(id: session[:id])
    elsif cookies.signed[:id]
      user = User.find_by(id: cookies.signed[:id])
      if user && user.authenticate(cookies[:remember_token])
        login(user)
        @current_user = user
      else
        @current_user = nil
      end
    end
  end

  def forget(user)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
