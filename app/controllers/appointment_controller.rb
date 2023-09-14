# frozen_string_literal: true

# Appointment controller
# rubocop:disable Metrics/AbcSize
class AppointmentController < ApplicationController
  before_action :require_user
  before_action :require_admin, only: [:all_appointments_in_admin_dashboard]
  include AppointmentHelper
  include FilterationHelper
  def request_from_seller
    request_appointment_data
    # @appointment_id = generate_appointment_id(@user_id, @car_id)
    appointment = Appointment.new(date: @date, user_id: @user_id,
                                  car_id: @car_id, status: 'Sell_Pending')
    if appointment.save
      update_selling_appointment_status(@car_id)
    else
      update_selling_appointment_status_failure
    end
  end

  def all_appointments
    @appointments = Appointment.where(user_id: session[:user_id])
  end

  def all_appointments_in_admin_dashboard
    @active_window = 'appointment'
    @appointments = Appointment.all
    default_sort_order(define_custom_order)
  end

  def status_update
    appointment = Appointment.find_by(id: params[:id])
    appointment.update(status: params[:status])
    CarsellingMailer.status_update(appointment.user, appointment).deliver_later

    notification_content = "Appoinment(#{appointment.appointment_id}) status has been updated to #{params[:status]}"
    notification = Notification.new(user_id: appointment.user_id, message: notification_content, status: false)
    send_notification(notification) if notification.save

    return unless appointment.user.role == 'seller'

    car = Car.find_by(reg_no: params[:reg_no])
    car.update(selling_appointment_status: params[:status])
  end

  def request_from_buyer
    request_appointment_data
    # @appointment_id = generate_appointment_id(@user_id, @car_id)
    appointment = Appointment.new(date: @date, user_id: @user_id, car_id: @car_id, status: 'Buy_Pending')
    if appointment.save
      success_for_request_from_buyer
    else
      failure_for_request_from_buyer
    end
  end

  def buyers_list
    @appointment = Appointment.find_by(id: params[:id])
    @car = Car.find_by(id: @appointment.car_id)
    @appointments = Appointment.where(car_id: @car.id)
  end

  def final_sell
    fetch_params_for_final_sell
    car = Car.find_by(id: @seller_appointment.car.id)
    all_appoinments_with_same_car = Appointment.where(car_id: car.id)
    handle_all_appointments(all_appoinments_with_same_car, car, @seller_appointment, @appointment)
    redirect_to appointments_path
  end

  def markread
    user = params[:selected_btn]
    notifications = Notification.where(user_id: user)
    notifications.update(status: true)
  end

  def status_check; end

  def find_status
    id = params[:status_input]
    @show_template = false
    if valid_appointment_id(id)
      handle_valid_appointments_status_checking(id)
    else
      flash[:danger] = 'Invalid Appointment ID. Try again!'
      redirect_to find_status_path
    end
  end

  private

  def request_appointment_data
    @date = params[:appointmentDate]
    @car_id = params[:car_id]
    @user_id = session[:user_id]
  end

  def fetch_params_for_final_sell
    @appointment = Appointment.find_by(id: params[:id])
    @seller_appointment = Appointment.find_by(id: params[:sell_appointment])
  end

  def handle_all_appointments(all_appoinments_with_same_car, car, seller_appointment, appointment)
    all_appoinments_with_same_car.each do |app|
      if app.user.role == 'buyer' && app.id != appointment.id
        handle_cancelled_appointments(app)
      elsif app.user.role == 'buyer' && app.id == appointment.id
        handle_bought_appointments(app, seller_appointment, car, appointment)
      else
        handle_successfull_sell_appointment(app, seller_appointment, appointment)
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
