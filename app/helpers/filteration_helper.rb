# frozen_string_literal: true

# filteration helper
# rubocop:disable all
module FilterationHelper
  def build_base_query
    Appointment.all
  end

  def collect_filter_values_from_params
    @role_filter = params[:role]
    @status_filter = params[:status]
    @sort_option = params[:sort_option]
  end

  def apply_role_filter
    @role_filter = params[:role]
    @appointments = @appointments.where(user_id: User.where(role: @role_filter).pluck(:id)) if @role_filter.present?
  end

  def define_status_values(_status_filter)
    case @status_filter
    when 'pending'
      %w[Sell_Pending Buy_Pending]
    when 'processing'
      %w[Sell_Processing Buy_Processing]
    when 'investigating'
      %w[Sell_Investigating Buy_Investigating]
    when 'ready'
      %w[Ready_for_Sell Ready_to_Buy]
    when 'sold'
      %w[Sold Bought]
    when 'reject'
      %w[Reject Buy_Request_Cancelled]
    else
      %w[Sell_Pending Buy_Pending Sell_Processing Buy_Processing Sell_Investigating Buy_Investigating Ready_for_Sell
         Ready_to_Buy Sold Bought Reject Buy_Request_Cancelled]
    end
  end

  def filter_appointments_by_status(status_values)
    @appointments = @appointments.where(status: status_values)
  end

  def define_custom_order
    {
      'Sell_Pending' => 1, 'Buy_Pending' => 2, 'Sell_Processing' => 3, 'Buy_Processing' => 4, 'Sell_Investigating' => 5,
      'Buy_Investigating' => 6, 'Ready_for_Sell' => 7, 'Ready_to_Buy' => 8, 'Sold' => 9, 'Bought' => 10, 'Reject' => 11,
      'Buy_Request_Cancelled' => 12
    }
  end

  def apply_custom_sorting(sort_option, custom_order)
    case sort_option
    when 'status-asc'
      @appointments = @appointments.sort_by { |a| custom_order[a.status] }
    when 'status-desc'
      @appointments = @appointments.sort_by { |a| -custom_order[a.status] }
    when 'car-brand-asc'
      @appointments = @appointments.joins(car: :brand).order('brands.name ASC')
    when 'car-brand-desc'
      @appointments = @appointments.joins(car: :brand).order('brands.name DESC')
    when 'car-model-asc'
      @appointments = @appointments.joins(car: :car_model).order('car_models.name ASC')
    when 'car-model-desc'
      @appointments = @appointments.joins(car: :car_model).order('car_models.name DESC')
    when 'date-created-asc'
      @appointments = @appointments.order(created_at: :asc)
    when 'date-created-desc'
      @appointments = @appointments.order(created_at: :desc)
    when 'appointment-date-asc'
      @appointments = @appointments.order(date: :asc)
    when 'appointment-date-desc'
      @appointments = @appointments.order(date: :desc)
    else
      # Default sort order
      default_sort_order(custom_order)
    end
  end

  def default_sort_order(custom_order)
    # Create a hash to map statuses to their corresponding sort order
    status_sort_order = define_custom_order

    # Define the sorting order using the CASE statement
    status_order_conditions = status_sort_order.map do |status, order|
      "WHEN '#{status}' THEN #{order}"
    end.join(" ")

    # Apply sorting based on the defined custom order
    @appointments = @appointments.order(
      Arel.sql("CASE status #{status_order_conditions} ELSE #{status_sort_order.size + 1} END ASC"),
      created_at: :asc, # Sort by created_at
      date: :asc # Sort by date
    )

    # Now, let's sort by user role (Seller > Buyer)
    @appointments = @appointments.joins(:user).order('users.role ASC')
  end





end
# rubocop:enable all
