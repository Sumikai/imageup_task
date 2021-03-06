class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:edit, :show]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render 'new'
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "登録情報を更新しました"
    else
      redirect_to user_path
    end
  end
  
  def edit
    
  end
  
  def show
    
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
