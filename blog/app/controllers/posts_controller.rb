class PostsController < ApplicationController
  before_action :find_post, only: [:show,:edit,:update]
  before_action :authenticate_user!, except:[:show,:index]
  before_action :authorize, only:[:destroy,:update]

  def index
    @first_post = Post.first
    @posts = Post.all
    # @counter = 0
  end

  def new
    @post = Post.new
  end
  def create

    post_params = params.require(:post).permit([:title,:body,:category_id])
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end

  end

  def show
    @comments = Comment.where(post_id: params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post_params = params.require(:post).permit([:title,:body,:category_id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to root_path,notice: 'Post deleted succesfully'
  end

  private

  def authorize
    @post = Post.find(params[:id])
    if cannot?(:manage, @post)
      redirect_to post_path(@post), alert: 'You can"t tho'
    end
  end
end
