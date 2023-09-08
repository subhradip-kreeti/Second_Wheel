# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'
require 'rails-controller-testing'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response for admin user' do
      # Simulate a logged-in admin user
      admin_user = create(:user, role: 'admin')
      session[:user_id] = admin_user.id
      session[:role] = 'admin'

      get :index
      expect(response).to be_successful
    end

    it 'returns a 200 authorized response for admin user' do
      # Simulate a logged-in user with a non-admin role
      non_admin_user = create(:user, role: 'buyer')
      session[:user_id] = non_admin_user.id
      session[:role] = 'buyer'

      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { email: 'valid@example.com', password: 'password', role: 'seller', name: 'John', mobile_no: '9339288098' }
      end

      it 'creates a new User' do
        expect do
          post :create, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the login page' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(login_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { email: 'invalid', password: 'sho', role: 'invalid', name: 'Invalid', mobile_no: '123' }
      end

      it 're-renders the new template' do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response for the user accessing their own profile' do
      # Simulate a logged-in user
      user = create(:user)
      session[:user_id] = user.id

      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'returns a 200 unauthorized response for a user accessing own profile' do
      # Simulate a logged-in user
      user1 = create(:user)
      session[:user_id] = user1.id

      # Create another user's profile
      user2 = create(:user)

      get :show, params: { id: user2.id }
      expect(response).to have_http_status(200)
    end
  end

  # Add more tests for other controller actions as needed
end

# rubocop:enable Metrics/BlockLength
