class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post_id = params[:post_id]
    @source_type = params[:source_type]
    @source_id = params[:source_id]
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_url(Post.find(@comment.post_id))
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :author_id, :commentable_id, :commentable_type, :post_id)
  end
end
