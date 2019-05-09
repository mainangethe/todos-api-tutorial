require 'rails_helper'

RSpec.describe 'Authentication', type: :request do

  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end
    context 'with valid request' do
      before { post '/auth/login', params: valid_credentials, headers: headers }
      it 'returns status code: 200' do
        expect(response).to have_http_status 200
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'with invalid request' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns status code: 401' do
        expect(response).to have_http_status 401
      end
      
      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end

    end

  end


end