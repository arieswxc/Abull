class WelcomeController < ApplicationController
  def index
    # @last_ten_funds   = Fund.last(10)
    @last_ten_funds   = Fund.where("state = 'gathering' or state = 'reached'").order(state: :asc, created_at: :desc).last(10)
    # @funds            = Fund.order(id: :desc)
    @last_ten_news    = News.last(10)
    @last_ten_topics  = Topic.last(10)
  end

  def funds
    
  end

  def notify_url

  end

  def return_url

  end
end
