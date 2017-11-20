class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy]
  before_action :check_logging_in, only: [:new, :edit, :index, :destroy]

  def index
    @blog = Blog.order(created_at: :desc)
  end

  def new
    @button = "投稿する"
    @page_title = "記事を新しく書く"
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    @button = "投稿する"
    @page_title = "記事を新しく書く"
    render :new if @blog.invalid?
  end

  def create
    @button = "投稿する"
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blogs_path, notice: "新しく記事を投稿しました"
    else
      render "new"
    end
  end

  def edit
    @button = "更新する"
    @page_title = "記事を編集する"
  end

  def update
    @button = "更新する"
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "記事を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @blog.destroy
      redirect_to blogs_path, notice: "記事を削除しました"
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def check_logging_in
    unless logged_in?
      redirect_to new_user_path
    end
  end


end
