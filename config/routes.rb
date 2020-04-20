Rails.application.routes.draw do
  namespace 'api' do
    resources :venues, only: :create
    resources :seats, only: :update
  end
end
