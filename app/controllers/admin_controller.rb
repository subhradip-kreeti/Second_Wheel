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
    respond_to(&:js)
  end

  def destroy_city
    city = City.find(params[:city_id])
    if city.destroy
      flash[:danger] = 'City deleted successfully'
    else
      flash[:error] = 'Failed to delete city'
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
  end

  def destroy_brand
    brand = Brand.find(params[:brand_id])
    if brand.destroy
      flash[:danger] = 'Brand deleted successfully'
    else
      flash[:error] = 'Failed to delete Brand'
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
end
