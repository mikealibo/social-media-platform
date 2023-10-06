Rails.application.routes.draw do
  devise_for :users

  scope module: 'user' do
    resources :posts, except: [:index, :edit] do
      post :edit, on: :member
      resources :comments, only: [:create]
    end
  end

  root to: "public#index"
end
