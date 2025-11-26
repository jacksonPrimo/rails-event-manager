require 'rails_helper'

RSpec.describe "Auth", type: :request do
  describe 'POST v1/auth/signin' do
    describe 'failure cases' do
      it 'return error when user not found' do
        post '/v1/auth/signin', params: { email: 'test', password: 'test' }
        expect(response).to have_http_status(:forbidden)
        expect(response.parsed_body['error']).to eq('password or email incorrect')
      end

      it 'return error when send password incorrect' do
        user = create(:user)
        post '/v1/auth/signin', params: { email: user.email, password: 'test' }
        expect(response).to have_http_status(:forbidden)
        expect(response.parsed_body['error']).to eq('password or email incorrect')
      end
    end

    describe 'success cases' do
      it 'authenticate user with success' do
        user = create(:user)
        post '/v1/auth/signin', params: { email: user.email, password: '123456' }
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['token']).not_to be_nil
        expect(response.parsed_body['exp']).not_to be_nil
      end
    end
  end

  describe 'POST v1/auth/signup' do
    describe 'failure cases' do
      it 'failure case email already in use' do
        user = create(:user)
        post '/v1/auth/signup', params: { name: 'jack', email: user.email, password: 'test' }
        expect(response).to have_http_status(:bad_request)
        expect(response.parsed_body['error']).to eq('email already in use')
      end

      it 'failure case password is too short' do
        post '/v1/auth/signup', params: { name: 'jack', email: 'jack-test@gmail.com', password: 'test' }
        expect(response).to have_http_status(:bad_request)
        expect(response.parsed_body['error']).to eq(
          'cannot register user: ["Password is too short (minimum is 6 characters)"]'
        )
      end
    end

    describe 'successfull cases' do
      it 'register a new user and return authentication token' do
        post '/v1/auth/signup', params: { name: 'jack', email: 'jack-test@gmail.com', password: '123456' }
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['token']).not_to be_nil
      end
    end
  end
end
