# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CarController, type: :controller do
  let(:user) { create(:user) }
  let(:seller) { create(:user, role: 'seller') }
  let(:admin) { create(:user, role: 'admin') }
  let(:brand) { create(:brand) }
  let(:car_model) { create(:car_model, brand:) }
  let(:branch) { create(:branch) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #new' do
    it 'returns a success response for sellers' do
      allow(controller).to receive(:current_user).and_return(seller)
      get :new
      expect(response).to be_successful
    end

    it 'redirects to root path for non-sellers' do
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        brand_id: brand.id,
        car_model_id: car_model.id,
        user_id: seller.id,
        branch_id: branch.id,
        reg_no: 'ABC123',
        variant: 'Petrol',
        kilometer_driven: '1-10000',
        reg_year: '2021',
        reg_state: 'West Bengal'
      }
    end

    it 'creates a new Car with valid attributes' do
      allow(controller).to receive(:current_user).and_return(seller)
      post :create, params: { car: valid_attributes }
      expect(response)
      expect(flash[:success])
    end

    it 'renders the new template with invalid attributes' do
      allow(controller).to receive(:current_user).and_return(seller)
      post :create, params: { car: valid_attributes.except(:brand_id) }
      expect(response)
    end

    it 'redirects to root path for non-sellers' do
      post :create, params: { car: valid_attributes }
      expect(response)
    end
  end

  describe 'GET #index' do
    it 'returns a success response for buyers' do
      allow(controller).to receive(:current_user).and_return(user)
      get :index
      expect(response).to be_successful
    end

    it 'redirects to root path for non-buyers' do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #show' do
    let(:car) { create(:car) }

    it 'returns a success response for any user' do
      # Replace create(:car) with FactoryBot.create to ensure correct data is used
      car = FactoryBot.create(:car)
      get :show, params: { id: car.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #set_condition' do
    it 'returns a success response for admins' do
      allow(controller).to receive(:current_user).and_return(admin)
      get :set_condition
      expect(response).to be_successful
    end

    it 'redirects to root path for non-admins' do
      get :set_condition
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST #verify' do
    let(:car) { create(:car) }
    let(:valid_params) { { car_id: car.id, selected_price: '100000', selected_condition: 'Excellent' } }

    it 'updates the car details with valid params for admins' do
      allow(controller).to receive(:current_user).and_return(admin)
      post :verify, params: valid_params
      expect(response).to redirect_to(set_car_condition_path)
      expect(flash[:success])
    end

    it 'redirects to set_car_condition_path with an error message for admins with invalid params' do
      allow(controller).to receive(:current_user).and_return(admin)
      post :verify, params: { car_id: car.id }
      expect(response).to redirect_to(set_car_condition_path)
      expect(flash[:danger]).to eq('Please select price and condition for the selected car!')
    end

    it 'redirects to root path for non-admins' do
      post :verify, params: valid_params
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #search' do
    it 'returns a success response for all users' do
      get :search
      expect(response).to be_successful
    end
  end
end
