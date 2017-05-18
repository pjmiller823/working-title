Rails.application.routes.draw do
  resources :submissions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'session#new'

  # session routes
  get    '/auth/:provider'          => 'omniauth#auth',    as: :auth
  get    '/auth/:provider/callback' => 'session#create'
  get    '/auth/failure'            => 'session#failure'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'

  # user routes
  get '/profile' => 'user#show'

  # group routes
  resources :groups, except: [:index, :destroy] do
    member do
      get '/submissions/:author_id' => 'groups#author_submissions', as: :author_submissions
    end
  end

  mount Shrine::DownloadEndpoint => "/attachments"
end
