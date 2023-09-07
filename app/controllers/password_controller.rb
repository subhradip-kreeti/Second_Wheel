# frozen_string_literal: true

# password controller
class PasswordController < ApplicationController
  include PasswordHelper
  def new
    session[:forgot_password_token] = 'hello'
  end

  def reset_link
    email = params[:email]
    if check_existance_of_email(email)
      send_reset_link
      flash[:success] = 'Password reset link has been sent to your email.Link will expire within 5 minutes.'
      redirect_to login_path
    else
      flash[:danger] = 'Email id not registered'
      redirect_to password_forget_path
    end
  end

  def password_reset
    return unless session[:reset_token_expire] < Time.now || params[:token] != session[:reset_token]

    flash[:danger] = 'Link has been Expired, Create new one here' if params[:auth].nil? || params[:auth] == false
    redirect_to password_forget_path
  end

  def update
    @user = User.find_by_email(session[:email])
    return unless this_same_with_last_password

    @user.update(password: params[:password])
    flash[:success] = 'Password updated successfully'
    session[:reset_token] = nil
    redirect_to login_path
  end
end
