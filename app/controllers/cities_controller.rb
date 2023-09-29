# frozen_string_literal: true

# city controller
class CitiesController < ApplicationController
  before_action :require_admin
  def index
    @active_window = 'city'
    @city = City.all
  end

  def create
    @city = City.new(name: params[:name], state: params[:state])

    if @city.save
      handle_successful_city_addition
    else
      handle_failed_city_addition
    end
  end

  def destroy
    city = City.find(params[:city_id])
    flash[:danger] = if city_has_associated_branches?(city)
                       "Cannot delete #{city.name} (#{city.state}) city as it has associated branches"
                     elsif city.destroy
                       "City #{city.name} (#{city.state}) has been deleted successfully"
                     else
                       "Failed to delete #{city.name} (#{city.state}) city"
                     end
    redirect_to cities_path
  end

  def update
    @city = City.find(params[:selected_city_id])
    if @city.update(name: params[:selected_city], state: params[:selected_state])
      flash[:success] = "City #{@city.name} (#{@city.state}) has been updated successfully"
    else
      flash[:danger] = 'Failed to update the city'
    end
    redirect_to cities_path
  end

  private

  # def cities_param
  #   params.require(:cities).permit(:name, :state)
  # end

  def handle_successful_city_addition
    flash[:success] = "City #{@city.name} (#{@city.state}) has been added successfully"
    redirect_to cities_path
  end

  def handle_failed_city_addition
    flash[:danger] = "Failed to add #{@city.name} (#{@city.state}) city"
    redirect_to cities_path
  end

  def city_has_associated_branches?(city)
    !city.branches.empty?
  end
end
