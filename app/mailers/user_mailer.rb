class UserMailer < ApplicationMailer
  default from: 'xianjieo@163.com'
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: '欢迎你注册')
  end
end
