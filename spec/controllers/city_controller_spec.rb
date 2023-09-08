# frozen_string_literal: true

require 'rails_helper'
require 'rails-controller-testing'

RSpec.describe CityController, type: :controller do
  # Create an admin user manually and set the session[:role] to 'admin'
  let(:admin_user) { create(:user, role: 'admin') }

  before do
    allow(controller).to receive(:current_user).and_return(admin_user)
    session[:role] = 'admin' # Manually set the role in the session
  end

  describe "GET #show_city" do
    it "returns a success response" do
      get :show_city
      expect(response).to be_successful
    end
  end

  describe "POST #add_city" do
    let(:valid_attributes) {
      { selected_city: "kolkata", selected_state: "West bengal" }
    }

    it "creates a new City with valid params" do
      expect {
        post :add_city, params: valid_attributes
      }.to change(City, :count).by(1)
    end

    it "redirects to the show city page with valid params" do
      post :add_city, params: valid_attributes
      expect(response).to redirect_to(show_city_path)
    end

    # Add tests for handling invalid params if needed
  end

  describe "DELETE #delete_city" do
    let!(:city) { create(:city) }

    it "deletes a City" do
      expect {
        delete :delete_city, params: { id: city.id }
      }.to change(City, :count).by(0)
    end

    # Add tests for handling cases where the city cannot be deleted if needed
  end

  describe "POST #update_city" do
    let!(:city) { create(:city) }
    let(:valid_attributes) {
      { id: city.id, selected_city: "City", selected_state: "Karnataka" }
    }

    it "updates the City with valid params" do
      post :update_city, params: valid_attributes
      city.reload
      expect(valid_attributes[:selected_city]).to eq("City")
      expect(valid_attributes[:selected_state]).to eq("Karnataka")
    end

  end
end
