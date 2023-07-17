# frozen_string_literal: true

# Home controller test
class HomeControllerTest < ActionDispatch::IntegrationTest
  require 'test_helper'
  test 'should get welcome' do
    get home_welcome_url
    assert_response :success
  end
end
