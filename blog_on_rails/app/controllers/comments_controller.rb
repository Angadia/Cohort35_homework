class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @new_comment = Comment.new comment_params
    @new_comment.user = current_user
    @new_comment.post = @post
    if @new_comment.save
      flash[:alert] = "Comment Created Succesfully"
      redirect_to @post
    else
      @comments = @post.comments.order(created_at: :desc)
      flash.now[:alert] = @new_comment.errors.full_messages.join(", ").gsub("Body", "Comment")
      render "posts/show"
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    flash[:alert] = "Comment Deleted Succesfully"
    redirect_to @comment.post
  end

  private 

  def comment_params 
    params.require(:comment).permit(:body)
  end
end
