Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :index, :show, :update] do
    resources :bottles, only: [:create, :index, :show, :update, :destroy]
    collection do
      post '/login', to: 'users#login'
    end
  end
  # resources :bottles do
  #   collection do
  #     get ':search'
  #   end
  # end
  get '/bottles/results/:search' => 'bottles#search', as: :search_results

end
