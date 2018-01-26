class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :show, :destroy, :favorite, :users]
  #before_action :current_user,   only: [:edit, :update]
  
  def top
    
  end
  
  def index
    @blogs = Blog.all
  end
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  def create
    @blog = Blog.new(blog_params)
    #現在ログインしているuserのidをblogのuser_idカラムに挿入
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: "記事を作成しました"
    else
      render 'new'
    end
  end
  
  def show
   @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end
  
  def update
    if @blog.update(blog_params)
      #ブログ一覧画面に戻ります
      redirect_to blogs_path, notice: "記事を編集しました"
    else
      #編集画面を再描画します
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "記事を削除しました"
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end
  
  def favorite
    @blogs = current_user.favorite_blogs
  end
  
  private
    def blog_params
      params.require(:blog).permit(:title, :content)
    end
    
  #クリックした記事のみ取得する
    def set_blog
      @blog = Blog.find(params[:id])
    end
end
