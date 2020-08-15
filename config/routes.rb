Rails.application.routes.draw do
  root to: 'posts#index'
  
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    collection do
      get 'search'
    end
    resource :relationships, only: [:create, :destroy]
    get 'followes' => 'relationships#follower', as: "followes"
    get 'followers' => 'relationships#followed', as: "followers"
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
