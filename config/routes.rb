# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  root 'home#welcome'
  get '/404', to: 'application#not_found'
  # users | authentication
  get 'dashboard/buyer_dashboard'
  get 'dashboard/seller_dashboard'
  get 'signup', to: 'users#new'

  post 'users', to: 'users#create'
  get 'users', to: 'users#new'
  get 'confirm_email', to: 'users#confirm_email'
  get 'show_all_users', to: 'users#index'
  patch 'make_admin', to: 'users#make_admin'
  delete 'delete_user', to: 'users#delete_user'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'login_verify', to: 'sessions#confirm_email'
  get 'confirm_message', to: 'sessions#confirm'
  get 'resend_verification_link', to: 'sessions#getting_resend_verification_link'
  post 'resend_verification_link', to: 'sessions#resend_verification_link'

  # city
  get 'show_city', to: 'city#show_city'
  post 'add_city', to: 'city#add_city'
  post 'update_city/:id', to: 'city#update_city', as: 'update_city'
  delete 'delete_city/:id', to: 'city#delete_city', as: 'delete_city'

  # admin
  get 'show_brand', to: 'admin#show_brand'
  post 'add_brand', to: 'admin#add_brand'
  post 'update_brand/:id', to: 'admin#update_brand', as: 'update_brand'
  delete 'delete_brand/:id', to: 'admin#destroy_brand', as: 'delete_brand'

  get 'show_car_model', to: 'admin#show_car_model'
  post 'add_car_model', to: 'admin#add_car_model'
  delete 'delete_car_model/:id', to: 'admin#destroy_car_model', as: 'delete_car_model'
  patch 'update_car_model/:id', to: 'admin#update_car_model', as: 'update_car_model'

  # dashboard
  get 'buyer_dashboard', to: 'dashboard#buyer_dashboard'
  get 'seller_dashboard', to: 'dashboard#seller_dashboard'
  get 'admin_dashboard', to: 'dashboard#admin_dashboard'

  # branch
  get 'branches', to: 'branch#index'
  get 'branch_details/:id', to: 'branch#show'
  post 'add_new_branch', to: 'branch#create'
  get 'view_branch', to: 'branch#view_branch'
  post 'getlocation', to: 'branch#getlocation'
  get 'getlocation', to: 'branch#view_branch'

  # car
  get 'add_new_car', to: 'car#new'
  post 'add_new_car', to: 'car#create'
  get 'show_car', to: 'car#show'
  get 'buyer_feed', to: 'car#index'
  get 'view_car/:id', to: 'car#show'
  get 'set_car_condition', to: 'car#set_condition'
  post 'set_car_condition/verify', to: 'car#verify'

  # searching
  get 'search_cars', to: 'car#search'
  get 'filter_cars', to: 'car#filter'

  # appointment
  post 'seller_dashboard/inspection_request', to: 'appointment#request_from_seller'
  post 'buyer_dashboard/inspection_request', to: 'appointment#request_from_buyer'
  get 'appointments', to: 'appointment#all_appointments'
  get 'appointments/verification', to: 'appointment#all_appointments_in_admin_dashboard'
  post 'appointments/status_update/:id', to: 'appointment#status_update'
  get 'appointments/buyers_list/:id', to: 'appointment#buyers_list'
  post 'appointment/buyers_list/final_sell/:id/:sell_appointment', to: 'appointment#final_sell'
  post 'markread', to: 'appointment#markread'
  get 'find_status', to: 'appointment#status_check'
  post 'find_status', to: 'appointment#find_status'
  # resources :users
  resources :users, except: [:destroy] do
    get 'my_profile', to: 'users#show', on: :member
    get 'edit_my_profile', to: 'users#edit', on: :member
    patch 'edit_my_profile', to: 'users#update', on: :member
  end

  # filteration
  get 'appointment_filter', to: 'filteration#appointment_filter'

  # fogot_password
  get 'password_forget', to: 'password#new'
  post 'password_reset_link', to: 'password#reset_link'
  get 'password_reset', to: 'password#password_reset'
  post 'password_update', to: 'password#update'

  match '*unmatched', to: 'application#not_found', layout: false, via: :all, constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage' # Exclude Active Storage routes
  }
end
# rubocop:enable Metrics/BlockLength
