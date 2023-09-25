# frozen_string_literal: true

# rubocop:disable Layout/LineLength
User.create!([

               { email: 'subhradip.barik@kreeti.com',
                 password_digest: '$2a$12$pCRPhUpqG6rDPJHJMqsooeGHUSnV7Xqq1tUk4zyCHDoQTLu0J4HmW', role: 'admin', confirmation_token: '__ocDnIuk9lHYv0kmv7iWw', confirmed_at: '2023-06-14 11:28:31', is_verified: true, token_expire: '2023-06-14 12:36:44 +0530', name: 'Subhradip Barik', mobile_no: '9339288098', latitude: nil, longitude: nil },

               { email: 'bariksubhradip@gmail.com', password_digest: '$2a$12$yvWvQ64Sd2Ec50urjZakLeWhqX47F.EO39glwEki.fk2C9WuQgWQe',
                 role: 'seller', confirmation_token: 'Zwb-ltWpGb01lxlqzCCU-A', confirmed_at: '2023-06-16 10:10:19', is_verified: true, token_expire: '2023-06-16 10:10:59 UTC', name: 'Dinesh Barik', mobile_no: '9339288098', latitude: nil, longitude: nil },

               { email: 'subhradipbarik2206@gmail.com',
                 password_digest: '$2a$12$OSjZeuDg7gy4uQuRujDUFuhiteFRXnQAduhhQN1IfnmX.fJbG8Any', role: 'buyer', confirmation_token: 'rBBX4CV32XiMsAVtYOcYJQ', confirmed_at: '2023-06-14 11:28:31', is_verified: true, token_expire: '2023-06-14 16:59:12 +0530', name: 'Moyukh Sarkar', mobile_no: '9339288098', latitude: nil, longitude: nil },

               { email: 'subhradip.it219056@bppimt.ac.in',
                 password_digest: '$2a$12$Z9BaZyNlwIKAxlhNH3IgpOTcSJrOfsEjlkHYrXKnRz.IOC3PVcyVa', role: 'buyer', confirmation_token: 'NxGaTdFUzlotprn1PuS4UQ', confirmed_at: '2023-06-15 11:44:40', is_verified: true, token_expire: '2023-06-15 17:14:58 +0530', name: 'Soyeb Akhtar', mobile_no: '9339288098', latitude: nil, longitude: nil },

               { email: 'bppit.11500219056@gmail.com',
                 password_digest: '$2a$12$Llb0pGVcwJ5wr7IwjZyrOe5JY4q4lzdm6veW9d9Fdc891pKCfwAkq', role: 'seller', confirmation_token: 'JStvlbVXTV4DT1GIi2fGXg', confirmed_at: '2023-06-15 11:47:39', is_verified: true, token_expire: '2023-06-15 17:18:13 +0530', name: 'Arpita Pal', mobile_no: '9339288098', latitude: nil, longitude: nil }
             ])

Brand.create!([
                { name: 'Tata' },
                { name: 'Maruti Suzuki' },
                { name: 'Mahindra' }
              ])

CarModel.create!([
                   { name: 'Tiago', brand_id: 1 },
                   { name: 'Nexon', brand_id: 1 },
                   { name: 'Safari', brand_id: 1 },
                   { name: 'Altroz', brand_id: 1 },
                   { name: 'Dezire', brand_id: 2 },
                   { name: 'Belano', brand_id: 2 },
                   { name: 'XUV500', brand_id: 3 },
                   { name: 'Thar', brand_id: 3 }
                 ])

City.create!([
               { name: 'Kolkata', state: 'West Bengal' },
               { name: 'Saltlake', state: 'West Bengal' },
               { name: 'Bengaluru', state: 'Karnataka' },
               { name: 'Bardhaman', state: 'West Bengal' },
               { name: 'Arambagh', state: 'West Bengal' },
               { name: 'Patna ', state: 'Bihar' },
               { name: 'Jamshedpur', state: 'Jharkhand' }
             ])

Branch.create!([
                 { name: 'Rudra Automobiles',
                   address: 'Raniganj Bazar, Bardhaman, Burdwan - I, Purba Bardhaman, West Bengal, 713102, India', map_link: 'https://goo.gl/maps/wNCcwetpZEQ1j4959', longitude: '87.8642749', latitude: '23.2410358', city_id: 4 },

                 { name: 'Prabhu Automobiles',
                   address: 'Godrej Genesis & Simoco Telecommunications (South Asia) Limited, Ring Road, GP Block, Sector V, Bidhannagar, Bhangar - II, South 24 Parganas, West Bengal, 700091, India', map_link: 'https://maps.google.com/maps?q=22.5731615%2C88.4336194&z=17&hl=en', longitude: '88.433872', latitude: '22.5728742', city_id: 1 },

                 { name: 'City Store', address: 'Link road,arambagh,712413', map_link: 'https://goo.gl/maps/S4A3UQaEJqUXCPac7',
                   longitude: '87.7910', latitude: '22.8813695', city_id: 5 },

                 { name: 'Ambey Motors', address: 'Sukanta Pally,Jhawtala,Baguiati,700157', map_link: 'https://goo.gl/maps/HpTa37u9Qg113vfcA', longitude: '88.4356482', latitude: '22.6205977', city_id: 1 }
               ])

car1 = Car.create!(condition: 'Excellent', brand_id: 2, car_model_id: 6, user_id: 5, branch_id: 3, variant: 'Diesel',
                   kilometer_driven: '10001-20000', reg_year: '2017', reg_state: 'jharkhand', price: '180000', selling_appointment_status: nil, reg_no: 'JH12A7845')

car1.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'baleno.jpeg')), filename: 'baleno.jpeg')

car2 = Car.create!(condition: 'Good', brand_id: 3, car_model_id: 7, user_id: 5, branch_id: 1, variant: 'Petrol',
                   kilometer_driven: '10001-20000', reg_year: '2019', reg_state: 'uttar_pradesh', price: '130000', selling_appointment_status: 'Ready_for_Sell', reg_no: 'UP14AX7896')

car2.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'xuv500.jpeg')), filename: 'xuv500.jpeg')

car3 = Car.create!(condition: 'Excellent', brand_id: 1, car_model_id: 3, user_id: 2, branch_id: 1, variant: 'Diesel',
                   kilometer_driven: '20001-40000', reg_year: '2017', reg_state: 'gujarat', price: '180054', selling_appointment_status: 'Ready_for_Sell', reg_no: 'GJ12AT4517')

car3.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'safari.jpeg')), filename: 'safari.jpeg')

car4 = Car.create!(condition: 'Fair', brand_id: 3, car_model_id: 8, user_id: 5, branch_id: 3, variant: 'Petrol',
                   kilometer_driven: '20001-40000', reg_year: '2015', reg_state: 'uttar_pradesh', price: '110000', selling_appointment_status: 'Sell_Pending', reg_no: 'UP14AX5241')

car4.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'thar.jpeg')), filename: 'thar.jpeg')

car5 = Car.create!(condition: nil, brand_id: 3, car_model_id: 8, user_id: 2, branch_id: 1, variant: 'Petrol',
                   kilometer_driven: '1-10000', reg_year: '2022', reg_state: 'sikkim', price: nil, selling_appointment_status: nil, reg_no: 'SK14AX4523')

car5.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'thar2.jpeg')), filename: 'thar2.jpeg')

car6 = Car.create!(condition: 'Good', brand_id: 1, car_model_id: 1, user_id: 2, branch_id: 1, variant: 'Petrol',
                   kilometer_driven: '1-10000', reg_year: '2018', reg_state: 'karnataka', price: '140000', selling_appointment_status: 'Ready_for_Sell', reg_no: 'KN01AX7894')

car6.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'tiago.jpg')), filename: 'tiago.jpg')

car7 = Car.create!(condition: 'Excellent', brand_id: 1, car_model_id: 4, user_id: 2, branch_id: 1, variant: 'CNG',
                   kilometer_driven: 'above 60000', reg_year: '2005', reg_state: 'punjab', price: '180000', selling_appointment_status: 'Ready_for_Sell', reg_no: 'PB17DZ7845')

car7.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'Altroz.jpg')), filename: 'Altroz.jpg')

car8 = Car.create!(condition: 'Excellent', brand_id: 2, car_model_id: 5, user_id: 5, branch_id: 1, variant: 'Petrol',
                   kilometer_driven: '1-10000', reg_year: '2022', reg_state: 'sikkim', price: '180000', selling_appointment_status: 'Ready_for_Sell', reg_no: 'SK01QT1245')

car8.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'dezire.jpeg')), filename: 'dezire.jpeg')

car9 = Car.create!(condition: 'Good', brand_id: 1, car_model_id: 2, user_id: 2, branch_id: 4, variant: 'Diesel',
                   kilometer_driven: '40001-60000', reg_year: '2019', reg_state: 'west_bengal', price: '130000', selling_appointment_status: 'Ready_for_Sell', reg_no: 'WB18AZ0245')

car9.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'nexon.jpeg')), filename: 'nexon.jpeg')

Appointment.create!([
                      { date: '2023-12-12', user_id: 2, status: 'Ready_for_Sell', car_id: 7, appointment_id: '02PB17DZ784507',
                        seller_status: nil, buyer_status: nil },
                      { date: '2023-12-14', user_id: 5, status: 'Ready_for_Sell', car_id: 8, appointment_id: '05SK01QT124508',
                        seller_status: nil, buyer_status: nil },
                      { date: '2023-12-13', user_id: 5, status: 'Ready_for_Sell', car_id: 2, appointment_id: '05UP14AX789602',
                        seller_status: nil, buyer_status: nil },
                      { date: '2023-12-16', user_id: 5, status: 'Sell_Pending', car_id: 4, appointment_id: '05UP14AX524104',
                        seller_status: nil, buyer_status: nil },
                      { date: '2023-12-14', user_id: 4, status: 'Ready_to_Buy', car_id: 3, appointment_id: '04GJ12AT451703',
                        seller_status: nil, buyer_status: nil },
                      { date: '2023-12-09', user_id: 2, status: 'Ready_for_Sell', car_id: 9, appointment_id: '02WB18AZ024509',
                        seller_status: nil, buyer_status: nil },
                      { date: '2023-12-12', user_id: 2, status: 'Ready_for_Sell', car_id: 3, appointment_id: '02GJ12AT451703',
                        seller_status: nil, buyer_status: nil },
                      { date: '2023-12-23', user_id: 2, status: 'Ready_for_Sell', car_id: 6, appointment_id: '02KN01AX789406',
                        seller_status: nil, buyer_status: nil }
                    ])

Notification.create!([
                       { user_id: 4,
                         message: ' appoinment for SK14BZ5789 status has been updated to Buy_Investigating', status: false },
                       { user_id: 4,
                         message: ' appoinment for SK14BZ5789 status has been updated to Buy_Processing', status: false },
                       { user_id: 4,
                         message: ' appoinment for WB07AZ5647 status has been updated to Buy_Processing', status: false },
                       { user_id: 2,
                         message: ' appoinment(64KN01AX789411) status has been updated to Ready_for_Sell', status: false },
                       { user_id: 2,
                         message: ' appoinment(64PB17DZ784515) status has been updated to Sell_Processing', status: false },
                       { user_id: 2, message: ' appoinment(64PB17DZ784515) status has been updated to Sell_Investigating',
                         status: false },
                       { user_id: 2,
                         message: ' appoinment(64PB17DZ784515) status has been updated to Ready_for_Sell', status: false },
                       { user_id: 5,
                         message: ' appoinment(63SK01QT124517) status has been updated to Sell_Processing', status: false },
                       { user_id: 5, message: ' appoinment(63SK01QT124517) status has been updated to Sell_Investigating',
                         status: false },
                       { user_id: 5,
                         message: ' appoinment(63SK01QT124517) status has been updated to Ready_for_Sell', status: false },
                       { user_id: 5,
                         message: ' appoinment(63UP14AX789619) status has been updated to Sell_Processing', status: false },
                       { user_id: 5,
                         message: ' appoinment(63UP14AX789619) status has been updated to Ready_for_Sell', status: false },
                       { user_id: 5, message: ' appoinment(63UP14AX789619) status has been updated to Sell_Investigating',
                         status: false },
                       { user_id: 4,
                         message: ' appoinment(62GJ12AT451714) status has been updated to Buy_Processing', status: false },
                       { user_id: 4, message: ' appoinment(62GJ12AT451714) status has been updated to Buy_Investigating',
                         status: false },
                       { user_id: 4,
                         message: ' appoinment(62GJ12AT451714) status has been updated to Ready_to_Buy', status: false }
                     ])
# rubocop:enable Layout/LineLength
