# frozen_string_literal: true

# Appointment Helper
module AppointmentHelper
  def update_selling_appointment_status(car_id)
    car = Car.find_by(id: car_id)
    car.update(selling_appointment_status: 'Sell_Pending')
    flash[:success] = " appointment booked successfully. Appointment id : #{@appointment_id}"
    redirect_to appointments_path
  end

  def update_selling_appointment_status_failure
    flash[:danger] = 'error occured while booking appointment.You are suggested to pick future dates'
    redirect_to seller_dashboard_path
  end

  def success_for_request_from_buyer
    flash[:success] = " appointment booked successfully.Appointment id : #{@appointment_id}"
    redirect_to appointments_path
  end

  def failure_for_request_from_buyer
    flash[:danger] = 'error occured while booking appointment.You are suggested to pick future dates'
    redirect_to buyer_feed_path
  end

  def handle_cancelled_appointments(app)
    @rejected_appointment = Appointment.find_by(id: app.id)
    @rejected_appointment.update(status: 'Buy_Request_Cancelled')
    CarsellingMailer.cancel_sell(@rejected_appointment.user).deliver_later
    notification_content = "Appoinment(#{app.appointment_id}) status has been updated to 'Buy_Request_Cancelled"
    notification = Notification.new(user_id: @rejected_appointment.user.id, message: notification_content,
                                    status: false)
    send_notification(notification) if notification.save
  end

  def handle_bought_appointments(app, seller_appointment, car, appointment)
    @success_appointment = Appointment.find_by(id: app.id)
    @success_appointment.update(status: 'Bought')
    CarsellingMailer.final_buy(seller_appointment.user, car, appointment.user).deliver_later
    notification_content = "your appoinment(#{app.appointment_id}) status has been updated to 'Bought'"
    notification = Notification.new(user_id: @success_appointment.user.id, message: notification_content,
                                    status: false)
    send_notification(notification) if notification.save
  end

  def handle_successfull_sell_appointment(app, seller_appointment, appointment)
    # binding.pry
    @success_sell_appointment = Appointment.find_by(id: app.id)
    # binding.pry
    @success_sell_appointment.update(status: 'Sold')
    # binding.pry
    car_id = @success_sell_appointment.car_id
    car = Car.find_by(id: car_id)
    car.update(selling_appointment_status: 'Sold')
    CarsellingMailer.final_sell(seller_appointment.user, car, appointment.user).deliver_later
    notification_content = "your appoinment(#{app.appointment_id}) status has been updated to 'Sold'"
    notification = Notification.new(user_id: @success_sell_appointment.user.id, message: notification_content,
                                    status: false)
    send_notification(notification) if notification.save
  end

  def valid_appointment_id(id)
    Appointment.exists?(appointment_id: id)
  end

  def check_if_user_own_that_appointment(id)
    appointment = Appointment.find_by(appointment_id: id)
    appointment.user_id == session[:user_id]
  end

  def find_targeted_appointment(id)
    @appointment = Appointment.find_by(appointment_id: id)
  end

  def handle_successfull_appointment_status_finding(id)
    find_targeted_appointment(id)
    flash[:success] = 'success'
    @show_template = true
  end

  def handle_valid_appointments_status_checking(id)
    if check_if_user_own_that_appointment(id)
      handle_successfull_appointment_status_finding(id)
    else
      flash[:danger] = "You are not allowed to check someone else's appointment status"
      redirect_to find_status_path
    end
  end

  def send_notification(notification)
    ActionCable.server.broadcast(
      "RoomChannel_#{notification.user_id}", {
        recipient_id: notification.user_id,
        message: notification.message
      }
    )
  end
end
