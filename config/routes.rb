Rails.application.routes.draw do
  devise_for :users

  scope module: 'user' do
    resource :profile, only: [:update] do
      post :edit
      post :password
      put :update_password
    end

    resources :posts, except: [:show, :index, :edit] do
      post :show, on: :member
      post :edit, on: :member
      resources :comments, only: [:create, :update, :destroy] do
        post :edit, on: :member
        post :see_all, on: :collection
        post :see_less, on: :collection
      end
    end
  end

  root to: 'public#index'
end
