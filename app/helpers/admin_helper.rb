# frozen_string_literal: true

# Branch helper
module AdminHelper
  def brand_has_associated_models?(brand)
    brand.car_models.exists?
  end
end
