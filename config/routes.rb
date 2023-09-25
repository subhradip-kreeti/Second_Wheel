# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  root 'home#welcome'
  get '/404', to: 'application#not_found'

  # session
  resources :sessions, only: %i[new create destroy]
  get 'login_verify', to: 'sessions#confirm_email'
  get 'resend_verification_link', to: 'sessions#getting_resend_verification_link'
  post 'resend_verification_link', to: 'sessions#resend_verification_link'

  # fogot_password
  get 'password_forget', to: 'password#new'
  post 'password_reset_link', to: 'password#reset_link'
  get 'password_reset', to: 'password#password_reset'
  post 'password_update', to: 'password#update'

  # user
  resources :users
  patch 'make_admin', to: 'users#make_admin'

  # city
  resources :cities

  # brand
  resources :brands, only: %i[index create update destroy]

  # car_model
  resources :car_models, only: %i[index create update destroy]

  # dashboard
  get 'admin_dashboard', to: 'dashboard#admin_dashboard'

  # branch
  resources :branches
  get 'find_nearest_branches', to: 'branches#all_branches'
  post 'getlocation', to: 'branches#getlocation'

  # car
  resources :cars, only: %i[new create index show]
  get 'set_car_condition', to: 'cars#set_condition'
  post 'set_car_condition/verify', to: 'cars#verify'

  # searching
  get 'search_cars', to: 'cars#search'
  # get 'filter_cars', to: 'cars#filter'

  # appointment
  post 'cars/inspection_request', to: 'appointment#request_from_seller'
  post 'buyer_dashboard/inspection_request', to: 'appointment#request_from_buyer'
  get 'appointments', to: 'appointment#all_appointments'
  get 'appointments/verification', to: 'appointment#all_appointments_in_admin_dashboard'
  post 'appointments/status_update/:id', to: 'appointment#status_update'
  get 'appointments/buyers_list/:id', to: 'appointment#buyers_list'
  post 'appointment/buyers_list/final_sell/:id/:sell_appointment', to: 'appointment#final_sell'
  post 'markread', to: 'appointment#markread'
  get 'find_status', to: 'appointment#status_check'
  post 'find_status', to: 'appointment#find_status'

  # filteration
  get 'appointment_filter', to: 'filteration#appointment_filter'
  get 'car_filter', to: 'filteration#car_filter'
  get 'filter_and_sort_general_user_appointment', to: 'filteration#filter_and_sort_general_user_appointment'

  match '*unmatched', to: 'application#not_found', layout: false, via: :all, constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage' # Exclude Active Storage routes
  }
end
# rubocop:enable Metrics/BlockLength
