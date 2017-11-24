class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_path, notice: "#{favorite.blog.user.name}さんのブログをお気に入りしました"
  end

  def destroy
    favorite = current_user.favorites.find_by(blog_id: params[:id]).destroy
    if params[:format] == "true"
      redirect_to favorite_blogs_path, notice: "#{favorite.blog.user.name}さんのブログをお気に入り解除しました"
    else
      redirect_to blogs_path, notice: "#{favorite.blog.user.name}さんのブログをお気に入り解除しました"
    end
  end

end
