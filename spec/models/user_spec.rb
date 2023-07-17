# frozen_string_literal: true

# user spec
# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'validates presence of email' do
      user = User.new(email: nil)
      expect(user.valid?).to eq(false)
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates uniqueness of email' do
      create(:user, email: 'existing@example.com')
      user = User.new(email: 'existing@example.com')
      expect(user.valid?).to eq(false)
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'validates length of password' do
      user = User.new(password: '1234')
      expect(user.valid?).to eq(false)
      expect(user.errors[:password]).to include('is too short (minimum is 5 characters)')
    end

    it 'validates presence of mobile_no' do
      user = User.new(mobile_no: nil)
      expect(user.valid?).to eq(false)
      expect(user.errors[:mobile_no]).to include("can't be blank")
    end

    it 'validates length of mobile_no' do
      user = User.new(mobile_no: '123456789')
      expect(user.valid?).to eq(false)
      expect(user.errors[:mobile_no]).to include('is too short (minimum is 10 characters)')
    end

    it 'validates presence of role' do
      user = User.new(role: nil)
      expect(user.valid?).to eq(false)
      expect(user.errors[:role]).to include("can't be blank")
    end

    it 'validates presence of name' do
      user = User.new(name: nil)
      expect(user.valid?).to eq(false)
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  context 'when creating a user' do
    let(:user) { build :user }

    it 'should be valid user with all required attributes' do
      expect(user.valid?).to eq(true)
    end
  end
end
# rubocop:enable Metrics/BlockLength
