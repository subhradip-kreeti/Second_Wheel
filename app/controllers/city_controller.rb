# frozen_string_literal: true

# city controller
class CityController < ApplicationController
  before_action :require_user
  before_action :require_admin
  def show_city
    @active_window = 'city'
    @city = City.all
  end

  def add_city
    @city = City.create(name: params[:selected_city], state: params[:selected_state])

    if @city.persisted?
      handle_successful_city_addition
    else
      handle_failed_city_addition
    end
  end

  def destroy_city
    city = City.find(params[:city_id])
    if city.destroy
      flash[:danger] = "City #{city.name} (#{city.state}) has been deleted successfully"
    else
      flash[:error] = "Failed to delete #{city.name} (#{city.state}) city"
    end
    redirect_to show_city_path
  end

  def update_city
    @city = City.find(params[:selected_city_id])
    if @city.update(name: params[:selected_city], state: params[:selected_state])
      flash[:success] = "City #{@city.name} (#{@city.state}) has been updated successfully"
    else
      flash[:error] = 'Failed to update the city'
    end
    redirect_to show_city_path
  end

  private

  def handle_successful_city_addition
    flash[:success] = "City #{@city.name} (#{@city.state}) has been added successfully"
    respond_to(&:js)
    redirect_to show_city_path
  end

  def handle_failed_city_addition
    flash[:danger] = "Failed to add #{@city.name} (#{@city.state}) city"
    redirect_to show_city_path
  end
end
