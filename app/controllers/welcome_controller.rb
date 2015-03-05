class WelcomeController < ApplicationController
  def index
    @last_ten_funds   = Fund.last(10)
    @funds            = Fund.order(id: :desc)
    @last_ten_news    = News.last(10)
    @last_ten_topics  = Topic.last(10)
  end
end