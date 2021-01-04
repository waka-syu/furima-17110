Rails.application.routes.draw do
  get 'purchases/index'
  devise_for :users
  root to: "items#index"
  resources :items, except: :index do
    collection do
      get :search
    end
    resources :purchases, only: [:index, :create]
  end

  resources :users, only: :show do
    resources :profiles, except: [:index, :show, :destroy]
  end
end
