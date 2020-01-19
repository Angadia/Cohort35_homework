class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post Created Successfully"
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @new_comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @post.update post_params
      flash[:notice] = "Post Updated Successfully"
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post Deleted Successfully"
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
