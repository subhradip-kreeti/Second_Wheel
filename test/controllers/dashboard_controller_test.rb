# frozen_string_literal: true

# Dashboard controller test
class DashboardControllerTest < ActionDispatch::IntegrationTest
  require 'test_helper'
  test 'should get buyer_dashboard' do
    get dashboard_buyer_dashboard_url
    assert_response :success
  end

  test 'should get cars' do
    get dashboard_cars_url
    assert_response :success
  end
end
