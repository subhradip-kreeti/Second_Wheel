# frozen_string_literal: true

# Filteration Controller
# rubocop:disable all
class FilterationController < ApplicationController
  include FilterationHelper
  def appointment_filter
    @active_window = 'appointment'
    @clear_filter = true

    collect_filter_values_from_params

    @appointments = build_base_query

    @appointments = @appointments.where(user_id: User.where(role: @role_filter).pluck(:id)) if @role_filter.present?

    @status_values = define_status_values(@status_filter)
    filter_appointments_by_status(@status_values)

    @custom_order = define_custom_order
    apply_custom_sorting(@sort_option, @custom_order)
  end

  def car_filter
    @filter = true
    @car = Car.all
               .by_city(params[:city])
               .by_brand(params[:brand])
               .by_model(params[:model])
               .by_reg_year(params[:reg_year])
               .by_variant(params[:variant])
               .by_reg_state(params[:reg_state])
               .by_kilometer_driven(params[:kilometer_driven])
               .ordered_by_created_at
  end

  def filter_and_sort_general_user_appointment
    @clear_filter = true
    @appointments = Appointment.all.where(user_id: session[:user_id])
    @status_filter = params[:statusFilter]
    @sort_option = params[:sortOption]
    @status_values = define_status_values(@status_filter)
    filter_appointments_by_status(@status_values)
    @custom_order = define_custom_order
    apply_custom_sorting(@sort_option, @custom_order)
  end
end
# rubocop:enable all
