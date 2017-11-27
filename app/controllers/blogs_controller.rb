class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy]
  before_action :check_logging_in, only: [:new, :edit, :index, :destroy, :favorite, :users]

  def index
    @blogs = Blog.order(created_at: :desc)
    @table_name = "全記事一覧"
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
    #下のvalidで引っかかりnewにrenderされてしまうからuser_idを代入
    @blog.user_id = current_user.id
    render 'new' if @blog.invalid?
  end

  def create
    @button = "投稿する"
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if params[:cache][:image].present?
      @blog.image.retrieve_from_cache! params[:cache][:image]
    end
      #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    if @blog.save
      redirect_to blogs_path, notice: "新しく記事を投稿しました"
    else
      render "new"
    end
  end

  def favorite
    @table_name = "#{current_user.name}さんのお気に入り一覧"
    @blogs = current_user.favorite_blogs.order(created_at: :desc)
    @check = true
  end

  def users
    @table_name = "#{current_user.name}さんの記事一覧"
    #has_many :blogs, belongs_to :userで結びついてuserのidの.blogでそのユーザーのブログ記事のレコードを全て取得できる
    @blogs = current_user.blogs.order(created_at: :desc)
  end

  def edit
    @button = "更新する"
    @page_title = "記事を編集する"
    @show_image = "true"

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
    params.require(:blog).permit(:title, :content, :image)
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
