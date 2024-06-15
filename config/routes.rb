Rails.application.routes.draw do
  resources :posts
  get 'steps_message/content'
  get 'steps_message/media'
  get 'steps_message/send_parameters'

  resources :messages do 
    collection do
      post 'update_content'
      post 'reload_content'

      post 'display_envoyes'
      post 'display_passes'
      post 'display_avenir'

    end
  end

    post 'messages/send_email', to: 'messages#send_email', as: 'send_email'

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

  root "pages#home"


end
