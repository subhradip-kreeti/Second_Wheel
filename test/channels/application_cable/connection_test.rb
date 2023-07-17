# frozen_string_literal: true

# Action cable test
# rubocop:disable Style/ClassAndModuleChildren
class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  require 'test_helper'
  # test "connects with cookies" do
  #   cookies.signed[:user_id] = 42
  #
  #   connect
  #
  #   assert_equal connection.user_id, "42"
  # end
end
# rubocop:enable Style/ClassAndModuleChildren
