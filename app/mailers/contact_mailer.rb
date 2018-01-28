class ContactMailer < ApplicationMailer
  def blog_mail(blog)
    @blog = blog
    mail to: @blog.user.email, subject: "新しく投稿しました"
  end
end
