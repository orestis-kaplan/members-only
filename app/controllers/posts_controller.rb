class PostsController < ApplicationController
  include SessionsHelper

  before_action :logged_in_user, only: [:new,:create]

  def new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
      flash[:success] = "Post successfully saved"
    end
  end

  def index
    @posts = Post.all
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in first"
      redirect_to login_url
    end
  end

  def post_params
    params.require(:post).permit(:title,:body)
  end

end
