# frozen_string_literal: true

# ApplicationSystemTestCase
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  require 'test_helper'
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
