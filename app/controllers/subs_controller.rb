class SubsController < ApplicationController
  before_action :moderator?, only: :edit
  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.includes(posts: :author).find(params[:id])
  end

  def moderator?
    @sub = Sub.find(params[:id])
    if current_user != @sub.moderator
      flash.now[:notice] = "Cannot edit sub"
      redirect_to sub_url(@sub)
    end
  end
  private

    def sub_params
      params.require(:sub).permit(:title, :description)
    end
end
