Rails.application.routes.draw do
  devise_for :users

  scope module: 'user' do
    resources :posts, only: [:create]
  end

  root to: "public#index"
end
