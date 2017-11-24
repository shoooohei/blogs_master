class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to blogs_path
    else
      render 'new'
    end
  end

  def show
    #has_many :blogs, belongs_to :userで結びついてuserのidの.blogでそのユーザーのブログ記事のレコードを全て取得できる
    @blog = User.find(current_user.id).blogs.order(created_at: :desc)
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

end
