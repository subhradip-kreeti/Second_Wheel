# frozen_string_literal: true

# Session controller test
class SessionsControllerTest < ActionDispatch::IntegrationTest
  require 'test_helper'
  test 'should get new' do
    get sessions_new_url
    assert_response :success
  end

  test 'should get create' do
    get sessions_create_url
    assert_response :success
  end

  test 'should get destroy' do
    get sessions_destroy_url
    assert_response :success
  end
end
