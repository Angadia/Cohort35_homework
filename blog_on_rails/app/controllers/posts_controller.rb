class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("updated_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new posts_params
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update posts_params
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def posts_params
    params.require(:post).permit(:title, :body)
  end
end
