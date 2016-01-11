class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @posts = if params[:user]
      Post.of_user(params[:user])
    else
      Post.all
    end
  end

  def create
    if user = User.has_log_token(post_params[:user_id], params[:post][:log_token]) && Post.create(post_params)      
      render json: { success: true }
    else
      render json: { success: false, errors: 'Invalid user' }
    end
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :title, :content)
  end
end