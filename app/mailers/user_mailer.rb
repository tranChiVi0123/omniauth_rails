class UserMailer < ApplicationMailer
  # default from: 'admin@example.com'
  def welcome
    @user = params[:user]
    @url  = 'http://www.gmail.com'
    mail(to:@user.email, subject: "Welcome to Rails OmniAuth")
  end
end
