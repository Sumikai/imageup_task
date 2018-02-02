class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :show, :destroy, :favorite]
  
  def top
    
  end
  
  def index
    @blogs = Blog.all
    @user = current_user
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
    @blog.user_id = current_user.id
    @blog.image.retrieve_from_cache!(params[:cache][:image]) if params[:cache][:image].present?
    
    respond_to do |format|
      if @blog.save
        BlogMailer.blog_mail(@blog).deliver
        format.html { redirect_to @blog, notice: "投稿しました" }
        format.json { render :index, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end
  
  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: "記事を編集しました"
    else
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
      params.require(:blog).permit(:title, :content, :image, :image_cache)
    end
    
    def set_blog
      @blog = Blog.find(params[:id])
    end
end
