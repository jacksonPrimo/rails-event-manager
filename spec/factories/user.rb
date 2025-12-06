# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'jack' }
    username { 'jack' }
    email { 'jack@gmail.com' }
    password { '123456' }
    role { 'normal' }

    factory :user_admin do
      email { 'jack-admin@gmail.com' }
      role { 'admin' }
    end
  end
end
