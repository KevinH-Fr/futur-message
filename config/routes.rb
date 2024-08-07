Rails.application.routes.draw do
  resources :produits
  resources :payments
  resources :posts
  get 'steps_message/content'
  get 'steps_message/media'
  get 'steps_message/send_parameters'

  resources :messages do 
    collection do
      post 'update_content'
      post 'reload_content'

    end
  end

    post 'messages/send_email', to: 'messages#send_email', as: 'send_email'
    post '/send_sms', to: 'messages#send_sms', as: 'send_sms'
  
  devise_for :users
  resources :users, only: [:index]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "about", to: "pages#about"

  # Defines the root path route ("/")

  get "home", to: "pages#home"
  get "about", to: "pages#about"
  get "testscroll", to: "pages#testscroll"


  get 'users/show'
  get 'users/:id' => 'users#show', as: 'user'

  get 'users/edit'
  get 'users/:id' => 'users#edit', as: 'user_edit'
  
  #stripe
  get 'purchase_success', to: 'stripe#purchase_success'
  post '/create_checkout_session', to: 'messages#create_checkout_session', as: 'create_checkout_session'

  root "pages#home"

end
