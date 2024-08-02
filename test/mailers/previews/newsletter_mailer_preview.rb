# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview
    def welcome_email
        NewsletterMailer.welcome_email(Subscription.first)
    end
end
