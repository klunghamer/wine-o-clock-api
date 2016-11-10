Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :update] do
    resources :bottles, only: [:create, :index, :show, :update, :destroy]
    collection do
      post '/login', to: 'users#login'
    end
  end

end
