# frozen_string_literal: true

# Mailer test
class CarsellingMailerTest < ActionMailer::TestCase
  require 'test_helper'
  test 'final_sell' do
    mail = CarsellingMailer.final_sell
    assert_equal 'Final sell', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
