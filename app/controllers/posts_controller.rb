class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @posts = if params[:email]
      Post.of_user(params[:email]).order(created_at: :desc)
    else
      Post.all
    end.order(created_at: :desc)
  end

  def create
    if user = User.has_log_token(post_params[:user_id], params[:log_token])
      post = Post.new(post_params)
      if post.save      
        render json: { success: true }
      else
        render json: { success: false, errors: post.errors.full_messages }, status: :unprocessable_entity  
      end  
    else
      render json: { success: false, errors: 'Invalid user' }, status: :unauthorized
    end
  end

  private
  def post_params
    params[:unique_id] = params[:uniqueid] if params[:uniqueid]
    params.permit(:user_id, :title, :content, :unique_id)
  end
end
