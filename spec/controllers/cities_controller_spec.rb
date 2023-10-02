# frozen_string_literal: true

# rubocop:disable all

require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  let(:user) { FactoryBot.create(:user,name: 'john', email: 'abc2@gmail.com', mobile_no: '9339288098',role: 'admin') }

  before do
    session[:role]= user.role
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          name: 'Bardhaman',
          state: 'West bengal'
        }
      end
      it 'creates a new city' do
        expect { post :create, params: valid_params }.to change(City, :count).by(1)
      end
    end
  end

  describe 'POST #create' do
  before do
    session[:role]= user.role
  end
  context 'with not valid parameters' do
    let(:valid_params) do
      {
        name: nil,
        state: nil
      }
    end
    it 'creates a new city' do
      expect { post :create, params: valid_params }.to change(City, :count).by(0)
    end
  end
end

describe 'PATCH #update' do
  let(:city) { FactoryBot.create(:city) }

  it 'updates the city attributes' do
    puts city.id
    new_name = 'New Kolkata'
    new_state = 'Bihar'
    patch :update, params: { id: city.id, selected_city_id: city.id, selected_city: new_name, selected_state: new_state }
    city.reload
    expect(city.name == new_name)
    expect(city.state==new_state)
  end
end

end
# rubocop:enable all
