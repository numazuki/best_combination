class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  
  def show
    @post = Post.find(params[:id])

  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    #@post.tag_id = params[:post][:tag_id]
    #binding.pry
    if @post.save!
      flash[:success]="maru"
      redirect_to root_url
    else
      flash[:danger]="batu"
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:success]="sakujo"
    head :no_content
  end

  private
  def post_params
    params.require(:post).permit(:sake_name,:meshi_name,:img,:content,:tag_id)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end

end
