# frozen_string_literal: true

# spec/controllers/branch_controller_spec.rb

require 'rails_helper'

RSpec.describe BranchController, type: :controller do
  let(:admin_user) { create(:user, admin: true) }
  let(:user) { create(:user, admin: false) }
  let(:city) { create(:city) }

  describe 'GET #index' do
    it 'requires authentication' do
      get :index
      expect(response).to redirect_to(login_path)
    end

    it 'requires admin privileges' do
      sign_in(user)
      get :index
      expect(response).to redirect_to(root_path)
    end

    it 'allows admin to access' do
      sign_in(admin_user)
      get :index
      expect(response).to be_successful
      expect(assigns(:active_window)).to eq('branches')
    end
  end

  describe 'GET #show' do
    let(:branch) { create(:branch) }

    it 'requires authentication' do
      get :show, params: { id: branch.id }
      expect(response).to redirect_to(login_path)
    end

    it 'allows authenticated users to access' do
      sign_in(user)
      get :show, params: { id: branch.id }
      expect(response).to be_successful
      expect(assigns(:branch)).to eq(branch)
    end
  end

  describe 'POST #create' do
    it 'requires authentication' do
      post :create
      expect(response).to redirect_to(login_path)
    end

    it 'requires admin privileges' do
      sign_in(user)
      post :create
      expect(response).to redirect_to(root_path)
    end

    it 'allows admin to create a branch' do
      sign_in(admin_user)
      post :create, params: {
        selected_city: city.id,
        selected_branch: 'Sample Branch',
        selected_address: 'Sample Address',
        selected_map: 'Sample Map Link',
        selected_lat: 123.456,
        selected_long: 789.123
      }
      expect(response).to have_http_status(:ok) # Assuming you're returning JSON
      expect(Branch.last.name).to eq('Sample Branch')
    end
  end

  # Add more test cases for other actions as needed
end
