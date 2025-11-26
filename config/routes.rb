Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  scope :v1 do
    scope :auth do
      post '/signin' => 'auth#signin'
      post '/signup' => 'auth#signup'
    end
  end
end
