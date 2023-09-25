# frozen_string_literal: true

# Brand controller
class BrandsController < ApplicationController
  include AdminHelper
  before_action :require_admin
  def index
    @active_window = 'brands'
    @brand = Brand.all
  end

  def create
    @brand = Brand.create(name: params[:selected_brand])
    respond_to(&:js)
    redirect_to brands_path
    if @brand.persisted?
      flash[:success] = "Brand #{@brand.name} has been added successfully"
    else
      flash[:danger] = "Failed to add #{@brand.name} brand"
    end
  end

  def destroy
    brand = Brand.find(params[:brand_id])
    flash[:danger] = if brand_has_associated_models?(brand)
                       "Brand #{brand.name} cannot be deleted because it has associated
                        datas.Delete those first"
                     elsif brand.destroy
                       "Brand #{brand.name} has been deleted successfully."
                     else
                       "Failed to delete #{brand.name} Brand."
                     end
    redirect_to brands_path
  end

  def update
    brand = Brand.find(params[:selected_brand_id])
    if brand.update(name: params[:selected_brand])
      flash[:success] = "Brand #{brand.name} has been updated successfully"
    else
      flash[:danger] = "Failed to update #{brand.name} brand"
    end
    redirect_to brands_path
  end
end
