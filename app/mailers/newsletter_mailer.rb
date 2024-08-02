class NewsletterMailer < ApplicationMailer

    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: 'Thanks for subscribing!')
    end
end
