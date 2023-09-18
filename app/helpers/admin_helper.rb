# frozen_string_literal: true

# Branch helper
module AdminHelper
  def brand_has_associated_models?(brand)
    brand.car_models.exists?
  end

  def car_model_has_associated_cars?(car_model)
    car_model.cars.exists?
  end
end
