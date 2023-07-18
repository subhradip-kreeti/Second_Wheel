# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  before_action :require_user, except: %i[new create]
  before_action :require_admin, only: [:make_admin]
  def index
    @active_window = 'users'
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.confirmation_email(@user).deliver_later
      flash[:success] = 'check your email to confirm your account'
      redirect_to login_path
    else
      render :new
    end
  end

  def show
    @user_show = User.find_by(id: session[:user_id])
  end

  def edit
    @user = User.find(params[:id])
    @render_template = true
    return unless @user.id != session[:user_id]

    @render_template = false
    flash[:danger] = "You are not allowed to enter someone's private profile"
    nil
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_update_params)
    flash[:success] = 'Info changed Successfully'
    redirect_to my_profile_user_path(session[:user_id])
  end

  def make_admin
    selected_user_id = params[:selected_user_id]

    user = User.find_by(id: selected_user_id)
    user.update(role: 'admin')

    respond_to(&:js)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :role, :name, :mobile_no)
  end

  def user_update_params
    params.require(:user).permit(:email, :mobile_no)
  end
end