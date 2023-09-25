# frozen_string_literal: true

# Dashboard controller
class DashboardController < ApplicationController
  before_action :require_user
  before_action :require_admin, only: [:admin_dashboard]
  before_action :require_buyer, only: [:buyer_dashboard]
  before_action :require_seller, only: [:cars]
  def buyer_dashboard; end

  def cars
    @car = Car.all
  end

  def admin_dashboard; end
end
