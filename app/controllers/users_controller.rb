# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  before_action :require_user, except: %i[new create]
  before_action :require_admin, only: %i[make_admin destroy]
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
      redirect_to new_session_path
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
    render file: Rails.public_path.join('401.html'), status: :unauthorized
    nil
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_update_params)
      flash[:success] = 'Info changed Successfully'
      redirect_to user_path(session[:user_id])
    else
      flash[:danger] = 'Failed to change info'
      @render_template = true
      render 'edit'
    end
  end

  def destroy
    selected_user_id = params[:selected_user_id]
    user = User.find_by(id: selected_user_id)

    return unless user.destroy

    redirect_to users_path
    flash[:warning] = "User #{user.email} deleted successfully"
  end

  def make_admin
    selected_user_id = params[:selected_user_id]

    user = User.find_by(id: selected_user_id)
    user.update(role: 'admin')
    redirect_to users_path
    flash[:success] = "User #{user.name} (#{user.email}) has been made an admin successfully"
    respond_to(&:js)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :role, :name, :mobile_no)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :mobile_no)
  end
end
