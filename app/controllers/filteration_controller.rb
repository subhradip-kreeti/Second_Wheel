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
    @car = @car.joins(branch: :city).where(cities: { name: params[:city] }) if params[:city].present?
    @car = @car.joins(:brand).where(brands: { name: params[:brand] }) if params[:brand].present?
    @car = @car.joins(car_model: :brand).where(car_models: { name: params[:model] }) if params[:model].present?
    @car = @car.where(reg_year: params[:reg_year]) if params[:reg_year].present?
    @car = @car.where(variant: params[:variant]) if params[:variant].present?
    @car = @car.where(reg_state: params[:reg_state]) if params[:reg_state].present?
    @car = @car.where(kilometer_driven: params[:kilometer_driven]) if params[:kilometer_driven].present?
    @car = @car.order(:created_at)
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
