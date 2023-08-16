# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user, :notification_count,:unread_notifications
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found
  def welcome
    @email = session[:email]
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_email
    User.find_by(id: session[:user_id]).email
  end

  def logged_in?
    session[:user_id].present?
  end

  def require_user
    return if logged_in?

    flash[:danger] = 'You must log in to continue'
    redirect_to root_path
  end

  def require_buyer
    return unless session[:role] != 'buyer'

    flash[:danger] = 'You are not authorized to access this url'
    redirect_to root_path
  end

  def require_seller
    return unless session[:role] != 'seller'

    flash[:danger] = 'You are not authorized to access this url'
    redirect_to root_path
  end

  def require_admin
    return unless session[:role] != 'admin'

    flash[:danger] = 'You are not authorized to access this url'
    redirect_to root_path
  end

  def not_found; end

  def notification_count
    current_user.notifications.where(status: false).count
  end

  def unread_notifications
    current_user.notifications.where(status: false)
  end

  private

  def render_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

end
