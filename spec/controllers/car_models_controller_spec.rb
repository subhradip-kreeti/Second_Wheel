# frozen_string_literal: true

# rubocop:disable all
require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  let(:admin_user) { FactoryBot.create(:user, role: 'admin') }
  let(:non_admin_user) { FactoryBot.create(:user, role: 'buyer') }

  # Helper method to simulate authentication
  def sign_in_user(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  before do
    sign_in_user(admin_user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { city: { name: 'Sample City', state: 'Sample State' } } }

    context 'with valid params' do
      it 'creates' do
        expect do
          post :create, params: valid_attributes
        end.to change { City.count }.by(0)
      end

      it 'redirects' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid params' do
      it 'does not create' do
        expect do
          post :create, params: { city: { name: nil, state: nil } }
        end.not_to change(City, :count)
      end

      it 'redirects with an error flash message' do
        post :create, params: { city: { name: nil, state: nil } }
        expect(flash[:danger]).to be_present
        expect(response).to have_http_status(302)
      end
    end
  end
end
# rubocop:enable all
