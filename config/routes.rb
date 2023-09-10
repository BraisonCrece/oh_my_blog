Rails.application.routes.draw do
  resources :articles do
    post :upload_image, on: :collection
  end
  devise_for :users
  root "articles#index"
end
