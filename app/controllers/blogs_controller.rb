class BlogsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :show, :destroy]
  before_action :current_user, only: [:new, :edit, :show, :destroy]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

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
    if @blog.save
      redirect_to blogs_path, notice: "記事を作成しました"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
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
    render :new if @blog.invalid?
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
