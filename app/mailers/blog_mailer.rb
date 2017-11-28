class BlogMailer < ApplicationMailer
  def blog_mail(blog)
    @blog = blog

    mail to: blog.user.email, subject: "ブログ記事投稿完了"
    # redirect_to blogs_path, notice: "新しく記事を投稿しました"
  end
end
