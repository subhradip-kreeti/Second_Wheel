# frozen_string_literal: true

# Branch helper
module BranchHelper
  def to_rad(degrees)
    degrees * Math::PI / 180
  end

  def calculate_a(delta_lat, user_lat_rad, branch_lat_rad, delta_lng)
    Math.sin(delta_lat / 2)**2 + Math.cos(user_lat_rad) * Math.cos(branch_lat_rad) * Math.sin(delta_lng / 2)**2
  end

  def calculate_c(atan)
    2 * Math.atan2(Math.sqrt(atan), Math.sqrt(1 - atan))
  end
end
