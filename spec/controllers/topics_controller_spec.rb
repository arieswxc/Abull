require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "GET #show" do
    it "assigns sign in user              as current_user,
        assigns the requested topic       as @topic,
        assigns the requested comments    as @comments,
        assigns the hot ten topics        as @hot_ten_topics,
        assigns the requested followings  as @followings" do
      user      = create(:user)
      following = create(:user)
      topic     = create(:topic)
      comment   = create(:comment, commentable: topic, user_id: topic.user.id)

      user.follow(following)

      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      
      get :show, {id: topic.to_param}
      expect(assigns(:current_user)).to         eq user
      expect(assigns(:topic)).to                eq topic
      expect(assigns(:comments).first).to       eq comment
      expect(assigns(:hot_ten_topics).first).to eq topic
      expect(assigns(:followings).first).to     eq following
    end

    it "assigns no more than 10 topics as @hot_ten_topics" do
      topic = create(:topic)
      20.times {create(:topic)}

      get :show, {id: topic.to_param}
      expect(assigns(:hot_ten_topics).count).to eq 10
    end
  end
end