# frozen_string_literal: true

class CarModelsController < ApplicationController
  include AdminHelper
  before_action :require_admin, only: %i[index create edit update]
  def index
    @active_window = 'model'
    @car = CarModel.all
    @brand = Brand.all
  end

  def create
    @model = CarModel.create(name: params[:selected_model], brand_id: params[:selected_brand])
    if @model.persisted?
      flash[:success] = 'Car Model added successfully'
    else
      flash[:danger] = "Failed to add Car Model.Error: #{@model.errors.full_messages_for(:name)}"
    end
    redirect_to car_models_path
  end

  def destroy
    car_model = CarModel.find(params[:carModelId])
    flash[:danger] = if car_model_has_associated_cars?(car_model)
                       'Car Model cannot be deleted because it has associated cars. Delete those first.'
                     elsif car_model.destroy
                       'Car Model deleted successfully.'
                     else
                       'Failed to delete Car Model.'
                     end
    redirect_to car_models_path
  end

  def update
    collecting_val_edit_car_model
    car_model = CarModel.find(@car_model_id)

    if car_model.update(name: @edited_car_model_name, brand_id: @edited_car_model_brand_id)
      flash[:success] = 'Car Model updated successfully'
    else
      flash[:danger] = 'Failed to update Car Model'
    end
    redirect_to car_models_path
  end

  private

  def collecting_val_edit_car_model
    @car_model_id = params[:carModelId]
    @edited_car_model_name = params[:editedCarModelName]
    @edited_car_model_brand_id = params[:editedCarModelBrandId]
  end
end
