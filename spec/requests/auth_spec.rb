require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe "POST /signin" do
    describe 'failure cases' do
      it "return error when user not found" do
        # post "/auth/signin", params: { email: 'test', password: 'test' }
        # expect(response).to have_http_status(:forbidden)
      end

      it "returns http success" do
        # post "/auth/signin", params: {email: 'test', password: 'test'}
        # expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST /signup" do
    it "returns http success" do
      # post "/auth/signup"
      # expect(response).to have_http_status(:success)
    end
  end
end
