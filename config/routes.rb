Rails.application.routes.draw do
  devise_for :users

  scope module: 'user' do
    resource :profile, only: [:show, :edit, :update]
    resources :posts, except: [:index, :edit] do
      post :edit, on: :member
      resources :comments, only: [:create, :update, :destroy] do
        post :edit, on: :member
        post :see_all, on: :collection
        post :see_less, on: :collection
      end
    end
  end

  root to: "public#index"
end
