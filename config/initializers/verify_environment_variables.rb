# frozen_string_literal: true

if ENV.fetch('RAILS_ENV') == 'development'
  required = %w[
    SECRET_KEY_BASE
    POSTGRES_USER
    POSTGRES_PASS
    POSTGRES_DB
    POSTGRES_PORT
    POSTGRES_HOST
    JWT_SECRET
  ].freeze

  missing_envs = required.select { |env| ENV.fetch(env, '').blank? }

  raise "Missing variables: #{missing_envs}" if missing_envs.present?
end
