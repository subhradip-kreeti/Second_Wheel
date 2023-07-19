# frozen_string_literal: true

# Car Selling mailer
class CarsellingMailer < ApplicationMailer
  def final_sell(user, car, buyer)
    @user = user
    @car = car
    @buyer = buyer

    mail(to: @user.email, subject: 'Congratulations ! Your Car Has Been Sold Successfully')
  end

  def cancel_sell(user)
    @user = user
    mail(to: @user.email, subject: 'Sorry! The buy request has been cancelled.')
  end

  def final_buy(user, car, buyer)
    @user = user
    @car = car
    @buyer = buyer

    mail(to: @buyer.email, subject: 'Congratulations ! Your Car Has Been Bought Successfully')
  end

  def status_update(user, appoinment)
    @user = user
    @appointment = appoinment
    mail(to: @user.email, subject: 'Appointment Status Update')
  end
end
