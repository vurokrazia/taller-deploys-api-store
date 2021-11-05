Rails.application.routes.draw do
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  scope '(:locale)', locale: /es|en/ do 
    get 'home/grettings'
    namespace :v1, defaults: { format: 'json' } do
      resources :users, only: %i[create] do
        #"v1/users/login"
        post 'login', on: :collection 
      end
      resources :stores, only: %i[show]
      resources :products, only: %i[create update index destroy] do
        #"v1/products/:product_id/restore"
        post 'restore'
      end
    end 
  end
end