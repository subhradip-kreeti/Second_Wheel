# frozen_string_literal: true

# Dashboard controller
class DashboardController < ApplicationController
  before_action :require_user
  before_action :require_admin, only: [:admin_dashboard]
  before_action :require_buyer, only: [:buyer_dashboard]
  before_action :require_seller, only: [:seller_dashboard]
  def buyer_dashboard; end

  def seller_dashboard
    @car = Car.all
  end

  def admin_dashboard; end
end
