class UsersController < ApplicationController
  # before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      Feed.create(user_id: @user.id)
      redirect_to blogs_path
    else
      render 'new'
    end
  end

  def edit
    @feed = Feed.find_by(user_id: params[:id])
  end

  # def update
  #   #updateするのに引数はハッシュでなくてはいけないからuser_updateでハッシュを作った
  #   # user_update = {name: user_edit[:name],
  #   #               image: user_edit[:image]}
  #   if @user.update_attributes(image: user_edit[:image])
  #     redirect_to edit_user_path(@user.id), notice:"更新しました"
  #   else
  #     render 'edit'
  #   end
  # end



  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def user_edit
    params.require(:user).permit(:name, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end



end
