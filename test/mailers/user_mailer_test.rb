# frozen_string_literal: true

# Mailer test
class UserMailerTest < ActionMailer::TestCase
  require 'test_helper'
  test 'confirmation_email' do
    mail = UserMailer.confirmation_email
    assert_equal 'Confirmation email', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
