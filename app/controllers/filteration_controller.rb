# frozen_string_literal: true

# Filteration Controller
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
end
