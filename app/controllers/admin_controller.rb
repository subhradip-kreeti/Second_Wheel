# frozen_string_literal: true

# admin controller
class AdminController < ApplicationController
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

  def show_brand
    @active_window = 'brands'
    @brand = Brand.all
  end

  def add_brand
    @brand = Brand.create(name: params[:selected_brand])
    respond_to(&:js)
    redirect_to show_brand_path
    if @brand.persisted?
      flash[:success] = "Brand #{@brand.name} has been added successfully"
    else
      flash[:danger] = "Failed to add #{@brand.name} brand"
    end
  end

  def destroy_brand
    brand = Brand.find(params[:brand_id])
    if brand.destroy
      flash[:danger] = "Brand #{brand.name} has been deleted successfully"
    else
      flash[:error] = "Failed to delete #{brand.name} Brand"
    end
    redirect_to show_brand_path
  end

  def show_car_model
    @active_window = 'model'
    @car = CarModel.all
    @brand = Brand.all
  end

  def add_car_model
    @model = CarModel.create(name: params[:selected_model], brand_id: params[:selected_brand])
    selected_brand_name = Brand.find_by(id: params[:selected_brand])&.name
    render json: { brand_name: selected_brand_name }
  end

  def destroy_car_model
    car_model = CarModel.find(params[:carModelId])
    if car_model.destroy
      flash[:danger] = 'Car Model  deleted successfully'
    else
      flash[:error] = 'Failed to delete Car Model'
    end
    redirect_to show_car_model_path
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
