# frozen_string_literal: true

# Branch helper
module BranchHelper
  def associated_data_present?
    @branch.cars.present?
  end

  def perform_branch_delete
    flash[:danger] = if @branch.destroy
                       'Branch has been deleted successfully'
                     else
                       'Error deleting this branch'
                     end
    redirect_to branches_path
  end

  def to_rad(degrees)
    degrees * Math::PI / 180
  end

  def calculate_a(delta_lat, user_lat_rad, branch_lat_rad, delta_lng)
    Math.sin(delta_lat / 2)**2 + Math.cos(user_lat_rad) * Math.cos(branch_lat_rad) * Math.sin(delta_lng / 2)**2
  end

  def calculate_c(atan)
    2 * Math.atan2(Math.sqrt(atan), Math.sqrt(1 - atan))
  end

  def branch_update_params
    params.require(:branch).permit(:city_id, :name, :address, :map_link, :latitude, :longitude)
  end

  def find_branch_from_params
    @branch = Branch.find(params[:id])
  end

  def getting_values_from_params_for_branch
    @city = params[:selected_city]
    @name = params[:selected_branch]
    @address = params[:selected_address]
    @map_link = params[:selected_map]
    @latitude = params[:selected_lat]
    @longitude = params[:selected_long]
  end

  def getting_location_from_params_and_find_in_geocoder
    @place = params[:place]
    @results = Geocoder.search(@place)
  end

  def handle_blank_result
    flash.now[:danger] = 'Enter a popular town/city'
    @render_template = false
  end
end
