# frozen_string_literal: true

# admin controller
class AdminController < ApplicationController
  include BranchHelper
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
    if brand_has_associated_models?(brand)
      flash[:error] = "Brand #{brand.name} cannot be deleted because it has associated models (cars)."
    elsif brand.destroy
      flash[:danger] = "Brand #{brand.name} has been deleted successfully."
    else
      flash[:error] = "Failed to delete #{brand.name} Brand."
    end
    redirect_to show_brand_path
  end

  def update_brand
    brand = Brand.find(params[:selected_brand_id])
    if brand.update(name: params[:selected_brand])
      flash[:success] = "Brand #{brand.name} has been updated successfully"
    else
      flash[:danger] = "Failed to update #{brand.name} brand"
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
    if @model.persisted?
      flash[:success] = 'Car Model added successfully'
    else
      flash[:danger] = 'Failed to add Car Model'
    end
    redirect_to show_car_model_path
  end

  def destroy_car_model
    car_model = CarModel.find(params[:carModelId])
    flash[:danger] = if car_model.destroy
                       'Car Model  deleted successfully'
                     else
                       'Failed to delete Car Model'
                     end
    redirect_to show_car_model_path
  end

  def update_car_model
    collecting_val_edit_car_model
    car_model = CarModel.find(@car_model_id)

    if car_model.update(name: @edited_car_model_name, brand_id: @edited_car_model_brand_id)
      flash[:success] = 'Car Model updated successfully'
    else
      flash[:danger] = 'Failed to update Car Model'
    end
    redirect_to show_car_model_path
  end

end
