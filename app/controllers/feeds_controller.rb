class FeedsController < ApplicationController
  def update
    @feed = Feed.find(params[:id])
    @feed.update(feed_params)
    redirect_to users_blogs_path, notice: "アイコンを変更しました"
  end

  private
  def feed_params
    params.require(:feed).permit(:image)
  end

end
