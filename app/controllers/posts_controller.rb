class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in?
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    if params[:post][:subs] == []
      flash.now[:errors] = ['You must select at least one sub']
      render :new
      return
    end
    if @post.save
      post_subs = params[:post][:subs]
      post_subs.each do |post_sub_id|
        PostSub.create(post_id: @post.id, sub_id: post_sub_id.to_i )
      end
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @subs = Sub.all
    if params[:post][:subs].nil? || params[:post][:subs].empty?
      flash.now[:errors] = ['You must select at least one sub']
      render :edit
      return
    end
    post_subs = @post.post_subs.map { |ps| ps.sub_id }
    new_post_subs = params[:post][:subs].map { |ps| ps.to_i }
    create_post_subs = new_post_subs - post_subs
    delete_post_subs = post_subs - new_post_subs
    if @post.update(post_params)
      delete_post_subs.each do |sub_id|
        PostSub.find_by(post_id: @post.id, sub_id: sub_id).destroy
      end
      create_post_subs.each do |sub_id|
        PostSub.create(post_id: @post.id, sub_id: sub_id)
      end
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    #@all_comments = Comment.where() where post id = the current post, then we want to do the iteration to eliminate n+1 queries
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to subs_url if current_user != @post.author
  end
  private

    def post_params
      params.require(:post).permit(:title, :url, :content, :author_id, :subs)
    end


end
