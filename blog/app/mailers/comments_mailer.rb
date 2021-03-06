class CommentsMailer < ApplicationMailer
  def notify_post_owner(comment)
    @comment = comment
    @post    = @comment.post
    @owner   = @post.user

    mail(to: @owner.email, subject: "You have a new comment")
  end
end
