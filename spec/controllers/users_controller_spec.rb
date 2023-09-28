# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'
require 'rails-controller-testing'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response for admin user' do
      admin_user = create(:user, role: 'admin')
      session[:user_id] = admin_user.id
      session[:role] = 'admin'

      get :index
      expect(response).to be_successful
    end

    it 'returns a 200 authorized response for admin user' do
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
        expect(response).to redirect_to(new_session_path)
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
end

# rubocop:enable Metrics/BlockLength
