Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }, skip: [:sessions]

  devise_scope :user do
    get 'sign_in', to: 'user_sessions#new', as: :new_user_session
    delete 'sign_out', to: 'user_sessions#destroy', as: :destroy_user_session
  end

  resources :repos, only: [:index]

  scope 'repos/:owner/:name' do
    resource :conversion, only: [:show, :new, :create]
  end

  root to: 'repos#index'
end
