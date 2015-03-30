class WelcomeController < ApplicationController
  def index
    # @last_ten_funds   = Fund.last(10)
    @last_ten_funds   = Fund.where("state = 'gathering' or state = 'reached'").order(state: :asc, created_at: :desc).last(10)
    # @funds            = Fund.order(id: :desc)
    @last_ten_news    = News.last(10)
    @last_ten_topics  = Topic.last(10)
    #测试代码
    uri       = URI.parse("http://222.73.117.158/msg/HttpBatchSendSM")
    msg       = "新的账户密码,请及时登陆摩尔街来修改帐号密码 【创蓝文化】"
    username  = 'jiekou-cs-02'
    password  = 'Tch147256'
    cell = 17601572017
    res = Net::HTTP.post_form(uri, account: username, pswd: password, mobile: cell, msg: msg, needstatus: true)
    puts "uri #{uri}  and res #{res.body}"
  end

  def funds
    
  end
end
