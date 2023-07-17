# frozen_string_literal: true

# Session controller
class SessionsController < ApplicationController
  include SessionsHelper
  def new; end

  def confirm; end

  def create
    @user = User.find_by(email: params[:email])
    return handle_invalid_credentials unless valid_user? && user_authenticated?

    if confirmed_and_verified_user?
      set_session_variables
      flash[:success] = 'Login successful'
      redirect_to_user_dashboard
    else
      handle_unverified_user
    end
  end

  def destroy
    reset_session
    flash[:success] = 'Logged out successfully.'
    redirect_to login_path
  end

  def confirm_email
    @user_present = User.find_by(confirmation_token: params[:token])
    if user_present_and_token_valid?
      update_user_confirmation_and_verification
      flash[:success] = 'Email was successfully confirmed. Now you can login.'
      redirect_to login_path
    else
      handle_expired_verification_link
    end
  end

  def getting_resend_verification_link; end

  def resend_verification_link
    @non_verified_user = User.find_by(email: params[:email])
    if user_present_and_not_verified?
      send_verification_email_and_update_token_expire
      flash[:success] = 'Check your email to confirm your account. The verification link will expire within 15 minutes.'
      redirect_to login_path
    elsif user_present_and_verified?
      handle_already_verified_user
    else
      handle_user_not_exist
    end
  end

  private

  def confirmed_and_verified_user?
    @user.confirmed_at.present? && @user.is_verified
  end

  def handle_unverified_user
    flash[:warning] = 'User not verified. Please confirm your email before logging in.'
    redirect_to login_path
  end
end
