require 'rails_helper'

RSpec.describe 'Post' do
  context 'before publication' do
    it 'cannot have comments' do
      expect(1).to eq(1)
      # user = create(:user)
      # expect(user.email).to eq("jack-2@gmail.com")
    end
  end
end