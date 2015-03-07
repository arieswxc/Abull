require 'rails_helper'

RSpec.describe FollowingTopicsController, type: :controller do
  describe "GET #index" do
    it "assigns user                  as @user,
        assigns followings            as @followings,
        assigns followers             as @followers,
        assigns all following topics  as @following_topics" do
      user      = create(:user)
      following = create(:user)
      follower  = create(:user)
      user.follow(following)
      follower.follow(user)
      20.times do
        create(:topic, user_id: following.id)
      end
      get :index, {user_id: user.to_param}
      expect(assigns(:user)).to                   eq user
      expect(assigns(:followings).first).to       eq following
      expect(assigns(:followers).first).to        eq follower
      expect(assigns(:following_topics).count).to eq 20
    end
  end
end