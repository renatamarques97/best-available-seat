Rails.application.routes.draw do
  namespace 'api' do
    resources :venues, only: :create
  end
end
