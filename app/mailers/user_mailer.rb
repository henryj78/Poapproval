class UserMailer < ActionMailer::Base
  default from: "henry.jackson@wetdesign.com"
  
  def poapproval_email(user)
      @user = user
      @url  = 'http://wetdesign.com/login'
      mail(to: @user, subject: 'Welcome to My Awesome Site')
    end
end
