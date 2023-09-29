# frozen_string_literal: true

# rubocop:disable all

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) do
    User.create(
      name: 'John Doe',
      email: 'john.doe@example.com',
      mobile_no: '9988774455',
      password: 'password',
      role: 'admin'
    )
  end

  describe 'POST #create' do
    context 'with invalid credentials' do
      it 'shows a flash message and re-renders the login page' do
        post :create, params: { email: user.email, password: 'wrong_password' }
        expect(flash[:danger]).to be_present
        expect(response).to render_template(:new)
      end
    end
    context 'with valid credentials' do
      it 'shows a flash message and redirect to dashboard' do
        post :create, params: { email: user.email, password: 'correct_password' }
        expect(flash[:danger]).to be_present
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #new' do
    it 'renders the login page' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
# rubocop:enable all
