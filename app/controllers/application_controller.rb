# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
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
  
  def not_found
    render status: :not_found
  end

  private

  def render_not_found
    redirect_to '/404'
  end
end
