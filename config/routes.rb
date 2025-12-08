Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  scope :v1 do
    scope :auth do
      post '/signin' => 'auth#signin'
      post '/signup' => 'auth#signup'
    end

    scope :admin do
      get '/list_all_users' => 'admin#list_all_users'
    end

    scope :event do
      post '/' => 'event#create'
    end
  end
end
