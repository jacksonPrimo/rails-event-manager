# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events' do
  let(:endpoint) { '/v1/event/' }

  describe 'POST /' do
    describe 'failure cases' do
      it 'return an error if the description is longer than 100 characters' do
        params = {
          description: 'Este é um pequeno parágrafo escrito apenas para cumprir o requisito de ter mais de cem caracteres, mantendo ainda assim um sentido claro.',
          title: 'exemplo'
        }

        post endpoint, params: params, headers: auth_header(create(:user))
        expect(response).to have_http_status(:unprocessable_content)
        expect(response.parsed_body['error']).to eq('cannot save this event')
        expect(response.parsed_body['details']).to eq('Description is too long (maximum is 100 characters)')
      end
    end

    describe 'success cases' do
      it 'return a new event' do
        params = {
          description: 'exemplo',
          title: 'exemplo'
        }

        post endpoint, params: params, headers: auth_header(create(:user))
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['title']).to eq('exemplo')
        expect(response.parsed_body['description']).to eq('exemplo')
      end
    end
  end
end
