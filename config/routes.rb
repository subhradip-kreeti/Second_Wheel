# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  root 'sessions#new'

  # users | authentication
  get 'dashboard/buyer_dashboard'
  get 'dashboard/seller_dashboard'
  get 'signup', to: 'users#new'

  post 'users', to: 'users#create'
  get 'users', to: 'users#new'
  get 'confirm_email', to: 'users#confirm_email'
  get 'show_all_users', to: 'users#index'
  patch 'make_admin', to: 'users#make_admin'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'login_verify', to: 'sessions#confirm_email'
  get 'confirm_message', to: 'sessions#confirm'
  get 'resend_verification_link', to: 'sessions#getting_resend_verification_link'
  post 'resend_verification_link', to: 'sessions#resend_verification_link'

  # admin
  get 'show_city', to: 'admin#show_city'
  post 'add_city', to: 'admin#add_city'
  delete 'delete_city/:id', to: 'admin#destroy_city', as: 'delete_city'

  get 'show_brand', to: 'admin#show_brand'
  post 'add_brand', to: 'admin#add_brand'
  delete 'delete_brand/:id', to: 'admin#destroy_brand', as: 'delete_brand'

  get 'show_car_model', to: 'admin#show_car_model'
  post 'add_car_model', to: 'admin#add_car_model'
  delete 'delete_car_model/:id', to: 'admin#destroy_car_model', as: 'delete_car_model'

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
end
# rubocop:enable Metrics/BlockLength
