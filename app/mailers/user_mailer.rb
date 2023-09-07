# frozen_string_literal: true

# User Mailer
class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Confirm Your Email')
  end

  def password_reset(email, link)
    @password_reset = link
    mail(to: email, subject: 'Password reset link')
  end
end
