# frozen_string_literal: true

# User controller test
class UsersControllerTest < ActionDispatch::IntegrationTest
  require 'test_helper'
  test 'should get new' do
    get users_new_url
    assert_response :success
  end

  test 'should get create' do
    get users_create_url
    assert_response :success
  end

  test 'should get confirm_email' do
    get users_confirm_email_url
    assert_response :success
  end
end
