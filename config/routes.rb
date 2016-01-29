Rails.application.routes.draw do
  resources :deals do
    get :live, on: :collection
  end

  resources :admins

  resources :users

  resources :orders, only: :create

  controller :sessions do
    post :login, action: :create
    delete :logout, action: :destroy
  end

  root to: 'admins#index'

end
