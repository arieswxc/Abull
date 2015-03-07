class FollowingTopicsController < ApplicationController
  def index
    @user             = User.find(params[:user_id])
    @followings       = @user.following_users
    @followers        = @user.followers
    @following_topics = Topic.where(user_id: @user.following_users.ids)
  end
end