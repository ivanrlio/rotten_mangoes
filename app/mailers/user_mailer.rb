class UserMailer < ActionMailer::Base
  
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/'
    mail(to: @user.email, subject: "Welcome to Rotten Mangoes!")
  end

  def delete_email(user)
    @user = user
    mail(to: @user.email, subject: "Rotten Mangoes account deleted!")
  end

end
