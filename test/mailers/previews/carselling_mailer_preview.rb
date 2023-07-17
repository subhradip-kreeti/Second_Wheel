# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/carselling_mailer
class CarsellingMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/carselling_mailer/final_sell
  def final_sell
    CarsellingMailer.final_sell
  end
end
