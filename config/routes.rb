Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :likes, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
      resources :posts do
        post :search, on: :collection
      end
      resources :users do
        post :search, on: :collection
        resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
        member do
          patch '/update_avatar', to: 'users#update_avatar'
          get '/posts', to: 'users#posts'
        end
      end
      resources :relationships,  only: [:create, :destroy]
    end
  end
end
