class TopicsController < ApplicationController
  def show
    @topic          = Topic.find(params[:id])
    @comments       = @topic.comments
    @hot_ten_topics = Topic.where("date >= ?", 1.month.ago).limit(10)
    @followings     = current_user.following_users if current_user
  end
end