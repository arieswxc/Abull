require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET #index" do
    it "assigns all funds       as @funs,
                last ten funds  as @last_ten_funds,
                last ten news   as @last_ten_news,
                last ten topics as @last_ten_topics" do
      20.times do
        create(:fund)
        create(:news)
        create(:topic)
      end
      get :index
      expect(assigns(:funds).count).to            eq 20
      expect(assigns(:last_ten_funds).count).to   eq 10
      expect(assigns(:last_ten_news).count).to    eq 10
      expect(assigns(:last_ten_topics).count).to  eq 10
    end
  end
end