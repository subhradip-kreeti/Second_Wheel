# frozen_string_literal: true

# Branch helper
module BranchHelper
  def brand_has_associated_models?(brand)
    brand.car_models.exists?
  end

  def collecting_val_edit_car_model
    @car_model_id = params[:carModelId]
    @edited_car_model_name = params[:editedCarModelName]
    @edited_car_model_brand_id = params[:editedCarModelBrandId]
  end
end
