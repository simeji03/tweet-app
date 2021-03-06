class PostsController < ApplicationController
  before_action :logout_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def follow
    @users = @current_user.followings
    # フォローしているuserのidからretweetレコードを取得
    @retweets = Retweet.where(user_id: @users.pluck(:id))
    # retweetレコードを元にフォローしているユーザーがリツイートしているpostを取得
    @retweet_posts = Post.where(id: @retweets.pluck(:post_id))
    # フォローしているuserのpostとリツイートしたpost、自分のpostを取得
    posts = Post.where(user_id: @users.pluck(:id)).or(@current_user.posts).or(@retweet_posts)
    # 取得したpostsをupdated_atの新しい順に並べ替える
    @posts = posts.sort_by{|post| post.updated_at}.reverse
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @retweets_count = Retweet.where(post_id: @post.id).count
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(content: params[:posts][:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "新しく投稿しました"
      redirect_to "/posts/follow"
    else
      render("posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:posts][:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to "/posts/follow"
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to "/posts/follow"
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to "/posts/follow"
    end
  end
end
