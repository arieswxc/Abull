# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer::Base.default_charset = "utf-8"   #  设置发送邮件的内容的编码类型
# ActionMailer::Base.default_content_type = "text/html"   # 发送邮件的默认内容类型
ActionMailer::Base.delivery_method = :smtp   # 以smtp邮件传送协议发送邮件
ActionMailer::Base.smtp_settings = {   # 邮件服务器的设置
  :address => "smtp.163.com",
  :port => 25,
  :domain => "163.com",
  :authentication => :login,
  :user_name => "xianjieo@163.com",
  :password => "z86352959"
}
