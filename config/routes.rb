Rails.application.routes.draw do
  namespace 'api' do
    resources :venues, only: [:create, :index] do
      resources :seats, only: :index, controller: "seats"
    end
    resources :batch_update_seats, only: :create
    resources :seats, only: :update
    resources :best_seats, only: :index
  end
end
