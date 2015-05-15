class PostsController < ApplicationController
  before_action :correct_user?, only: [:edit, :update]
  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @sub = Sub.find(params[:sub_id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def correct_user?
    @post = Post.find(params[:id])
    redirect_to sub_url(@post.sub) if current_user != @post.author
  end
  private

    def post_params
      params.require(:post).permit(:title, :url, :content, :author_id, :sub_id)
    end
end
