# frozen_string_literal: true

# Car controller
class CarController < ApplicationController
  before_action :require_user
  before_action :require_admin, only: %i[set_condition verify]
  before_action :require_seller, only: %i[new create]
  before_action :require_buyer, only: [:index]
  def new
    @car = Car.new
    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def create
    @car = Car.new(car_params)
    @car.update(user_id: session[:user_id])
    if @car.save
      flash[:success] = 'Car added successfully'
      redirect_to add_new_car_path
    else
      render :new
    end
  end

  def index
    @car = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def set_condition
    @active_window = 'car-condition'
    @car = Car.where(price: nil)
  end

  def verify
    @car = Car.find_by(id: params[:car_id])
    if params_present?
      update_car_details
      send_verification_sms
      handle_success
    else
      handle_failure
    end
  end

  def search
    query = params[:search_cars].presence && params[:search_cars][:query]
    return unless query

    @car = Car.search_car(query)
    puts @car
    return unless @car.empty?

    redirect_to buyer_feed_path
    flash[:warning] = 'No matching records found.'
  end

  def filter; end

  private

  def car_params
    params.require(:car).permit!
  end

  def params_present?
    params[:selected_price].present? && params[:selected_condition].present?
  end

  def update_car_details
    @car.update(price: params[:selected_price], condition: params[:selected_condition])
  end

  def send_verification_sms
    twilio_client = TwilioClient.new
    text = "Hello #{@car.user.name}, thank you for uploading your vehicle. "\
          'Now your vehicle has been verified and the estimated price of your car is: '\
          "#{@car.price}. If you haven't scheduled an appointment yet, do so right now "\
          'to continue your selling process'

    twilio_client.send_text(@car.user.mobile_no, text)
  rescue StandardError => e
    Rails.logger.error "Failed to send SMS: #{e.message}"
    flash[:warning] = 'Failed to send SMS, cause: not a valid mobile number'
  end

  def handle_success
    flash[:success] = 'Car successfully verified'
    redirect_to set_car_condition_path
  end

  def handle_failure
    flash[:danger] = 'Please select price and condition for the selected car!'
    redirect_to set_car_condition_path
  end
end
