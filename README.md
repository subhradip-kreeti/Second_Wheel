# README

This README would normally document whatever steps are necessary to get the
application up and running.


* Ruby version -> 3.2.2

* Rails version -> 6.1.7.3

* Webpacker Version -> 5.4.4

* Node Version -> 16.20.0

* Yarn Version -> 1.22.19

* database used -> postgresql

## setup instruction:

```rails webpacker:install```

### then remove the babel.config.js

```rails webpacker:compile```

**make sure to start elasticsearch server before seeding the database**

```rails db:create```

```rails db:migrate```

```rails db:seed```

## Necessary Accounts

subhradip.barik@kreeti.com  (admin)

bariksubhradip@gmail.com  (seller)

bppit.11500219056@gmail.com (seller)

subhradip.it219056@bppimt.ac.in (buyer)

subhradipbarik2206@gmail.com (buyer)

## Account Password

subhradip123
** same password for each account

## Twilio Client setup ( for sms sending )

follow passwords.txt for details
look at : app/services/twilio_client.rb
