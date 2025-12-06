# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admins' do
  describe 'GET /list-all-users' do
    let(:endpoint) { '/v1/admin/list_all_users' }

    describe 'failure cases' do
      it 'return unauthorized error when user is not authenticated' do
        get endpoint
        expect(response).to have_http_status(:unauthorized)
      end

      it 'return forbidden error when user is not an admin' do
        get endpoint, headers: auth_header(create(:user))
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'success cases' do
      it 'list users' do
        create(:user)
        get endpoint, headers: auth_header(create(:user_admin))
        expect(response).to have_http_status(:ok)
        body = response.parsed_body
        expect(body).to all(include('id', 'email', 'role'))
        expect(body.size).to eq(2)
        expect(body.pluck('email')).to match_array(['jack@gmail.com', 'jack-admin@gmail.com'])
      end
    end
  end
end
