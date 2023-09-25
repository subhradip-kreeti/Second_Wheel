# frozen_string_literal: true

# password helper
module PasswordHelper
  require 'securerandom'
  def check_existance_of_email(email)
    User.find_by_email(email)
  end

  def send_reset_link
    @confirmation_token = SecureRandom.urlsafe_base64
    @token_expire = Time.now + 5.minutes
    collect_data_in_session
    UserMailer.password_reset(params[:email], @confirmation_token).deliver_later
  end

  def collect_data_in_session
    session[:reset_token] = @confirmation_token
    session[:reset_token_expire] = @token_expire
    session[:email] = params[:email]
  end

  def this_same_with_last_password
    if @user.authenticate(params[:password])
      flash[:warning] = "New password can't be the same as the last password. Please try a different password."
      redirect_to password_reset_path(token: session[:reset_token], auth: true)
      return false
    end
    true
  end
end
