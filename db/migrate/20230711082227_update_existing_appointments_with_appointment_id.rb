# frozen_string_literal: true

# genarate and Add appointment_id value to the rows those were created previously
class UpdateExistingAppointmentsWithAppointmentId < ActiveRecord::Migration[6.0]
  def up
    Appointment.find_each do |appointment|
      user_id_part = appointment.user_id.to_s.rjust(2, '0')
      car_reg_no = appointment.car.reg_no
      car_id_part = appointment.car_id.to_s.rjust(2, '0')
      appointment.update(appointment_id: "#{user_id_part}#{car_reg_no}#{car_id_part}")
    end
  end

  def down
    Appointment.update_all(appointment_id: nil)
  end
end
