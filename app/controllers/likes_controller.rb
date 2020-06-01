class LikesController < ApplicationController
  before_action :logout_user
  
  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
