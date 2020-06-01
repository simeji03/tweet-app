class RetweetsController < ApplicationController
  
  def create
    @retweet = Retweet.new(user_id: @current_user.id, post_id: params[:post_id])
    @retweet.save
    @post = Post.find(@retweet.post_id)
    @post.update_attribute(:updated_at, Time.now)
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @retweet = Retweet.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @post = Post.find(@retweet.post_id)
    @post.update_attribute(:updated_at, Time.now)
    @retweet.destroy
    redirect_back(fallback_location: root_path)
  end
end
