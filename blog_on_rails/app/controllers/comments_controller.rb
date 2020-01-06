class CommentsController < ApplicationController
  def create
    @comment = Comment.new({ body: params[:body], post_id: params[:post_id] })
    @comment.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @comment = Comment.find params[:id]
    post_id = @comment.post_id
    @comment.destroy
    redirect_to post_path(post_id)
  end
end
