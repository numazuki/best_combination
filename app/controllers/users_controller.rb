class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(5)
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success] = "seikou"
      redirect_to @user
    else
      flash[:danger] = "batu"
      render :new
    end
  end
  

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success]='変更しました'      
      redirect_to @user
    else
      flash[:danger]="失敗しました"
      render :edit
    end
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorite_posts.order(id: :desc).page(params[:page]).per(5)
   
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:introduce,:email,:img,:password, :password_confirmation)
  end
  
end
