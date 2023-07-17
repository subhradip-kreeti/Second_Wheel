# frozen_string_literal: true

# Branch controller
class BranchController < ApplicationController
  include BranchHelper
  before_action :require_user
  before_action :require_admin, only: %i[index create]
  def index
    @active_window = 'branches'
    @branch = Branch.all
    @city = City.all
  end

  def show
    @branch = Branch.find(params[:id])
    @city = City.find_by(id: @branch.city_id)
  end

  def create
    @branch = Branch.create(city_id: @city, name: @name,
                            address: @address, map_link: @map_link, latitude: @latitude, longitude: @longitude)
    getting_values_from_params_for_branch
    selected_city_name = City.find_by(id: params[:selected_city])&.name
    render json: { city_name: selected_city_name }
  end

  def view_branch
    @branch = Branch.all
    @city = City.all
  end

  def getlocation
    getting_location_from_params_and_find_in_geocoder
    @count = 0
    @render_template = true
    if @results.blank?
      handle_blank_result
      return
    end
    calculate_coordinates(@results)
    @nearest_branches = @sorted_branches.first(5).map { |bw| bw[:branch] }
    @nearest_distances = @sorted_branches.first(5).map { |bw| bw[:distance] }
  end

  private

  def haversine_distance(user_lat, user_lng, branch_lat, branch_lng)
    earth_radius = 6371
    user_lat_rad = to_rad(user_lat)
    user_lng_rad = to_rad(user_lng)
    branch_lat_rad = to_rad(branch_lat)
    branch_lng_rad = to_rad(branch_lng)
    delta_lat = branch_lat_rad - user_lat_rad
    delta_lng = branch_lng_rad - user_lng_rad
    a = calculate_a(delta_lat, user_lat_rad, branch_lat_rad, delta_lng)
    c = calculate_c(a)
    earth_radius * c
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

  def calculate_coordinates(results)
    coordinates = results.first.coordinates
    @user_lng = coordinates[1]
    @user_lat = coordinates[0]
    calculate_distance(@user_lat, @user_lng)
  end

  def calculate_distance(user_lat, user_lng)
    branches = Branch.all.to_a
    @branches_with_distances = branches.map do |branch|
      branch_lng = branch.longitude.to_f
      branch_lat = branch.latitude.to_f
      distance = haversine_distance(user_lat, user_lng, branch_lat, branch_lng)
      { branch:, distance: }
    end
    @sorted_branches = @branches_with_distances.sort_by { |bw| bw[:distance] }
  end

  def handle_blank_result
    flash.now[:danger] = 'Enter a popular town/city'
    @render_template = false
  end
end
