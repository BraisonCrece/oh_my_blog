Rails.application.routes.draw do
  resources :profiles, only: [:show, :edit, :update]
  resources :articles do
    post :upload_image, on: :collection
  end
  devise_for :users
  root "articles#index"
end
