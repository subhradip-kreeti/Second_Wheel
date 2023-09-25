# frozen_string_literal: true

# Session Helper
module SessionsHelper
  def user_params
    params.require(:user).permit(:email, :password, :role, :name)
  end

  def valid_user?
    @user.present?
  end

  def user_authenticated?
    @user.authenticate(params[:password])
  end

  def confirmed_or_verified_user?
    user_authenticated?
  end

  def set_session_variables
    session[:user_id] = @user.id
    session[:role] = @user.role
    session[:email] = @user.email
    cookies.signed[:user_id] = @user.id
  end

  def redirect_to_user_dashboard
    case session[:role]
    when 'buyer'
      redirect_to cars_path
    when 'seller'
      redirect_to cars_path
    else
      redirect_to admin_dashboard_path
    end
  end

  def handle_invalid_credentials
    flash[:danger] = 'Invalid email or password.'
    render :new
  end

  def user_present_and_token_valid?
    @user_present && @user_present.token_expire > Time.now
  end

  def update_user_confirmation_and_verification
    @user_present.update(confirmed_at: Time.current, is_verified: true)
    @user_present.save
  end

  def handle_expired_verification_link
    flash[:danger] = 'Verification link expired. Enter your email to get a new verification link.'
    redirect_to resend_verification_link_path
  end

  def user_present_and_not_verified?
    @non_verified_user && !@non_verified_user.is_verified
  end

  def user_present_and_verified?
    @non_verified_user&.is_verified
  end

  def send_verification_email_and_update_token_expire
    send_verification_email
    update_token_expire
  end

  def send_verification_email
    UserMailer.confirmation_email(@non_verified_user).deliver_now
  end

  def update_token_expire
    @non_verified_user.update(token_expire: Time.current + 15.minutes)
  end

  def handle_already_verified_user
    flash[:warning] = 'User already verified. You can login.'
    redirect_to new_session_path
  end

  def handle_user_not_exist
    flash[:warning] = 'User does not exist. Sign up to create an account.'
    redirect_to new_user_path
  end

  def redirect_user
    if session[:role] == 'buyer'
      redirect_to cars_path
    elsif session[:role] == 'seller'
      redirect_to cars_path
    else
      redirect_to admin_dashboard_path
    end
  end
end
