# frozen_string_literal: true

# TwiloClient
class TwilioClient
  attr_accessor :client

  def initialize
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def send_text(user_phone, message)
    formatted_phone = "+91#{user_phone}"
    puts formatted_phone
    puts message
    sms_response = @client.messages.create(
      from: phone_number,
      to: formatted_phone,
      body: message
    )

    # binding.pry

    puts @client
    puts '******************************************************************'
    puts sms_response
    puts '******************************************************************'
  end

  private

  def account_sid
    # Rails.application.credentials.twilio[:account_sid]
    # replace sid from passwords.txt
    # 'AC0475b1cad848be1ac8dee5520afdc710'
  end

  def auth_token
    # Rails.application.credentials.twilio[:auth_token]
    # 'auth_token' # replace auth_token from passwords.txt
    '10860e324d4ef42ce520c6532e28304b'
  end

  def phone_number
    # Rails.application.credentials.twilio[:phone_number]
    # 'phone_number' # replace phone_number from passwords.txt
    '+15419379403'
  end
end
