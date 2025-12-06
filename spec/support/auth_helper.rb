# frozen_string_literal: true

module AuthHelper
  def auth_header(user)
    { Authorization: "Bearer #{encode_token(user)[:token]}" }
  end
end
