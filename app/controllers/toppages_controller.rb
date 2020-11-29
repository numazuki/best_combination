class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      if params[:tag_id].present?
        @posts= Tag.find(params[:tag_id]).posts.search(params[:search]).order(id: :desc).page(params[:page]).per(5) 
      else
        @posts= Post.all.search(params[:search]).order(id: :desc).page(params[:page]).per(5) 
      end
    end
  end
end
