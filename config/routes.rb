Rails.application.routes.draw do
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
  get  '/new'    => 'group#new'
  post '/create' => 'group#create'
  get  '/group'  => 'group#show'

  mount Shrine::DownloadEndpoint => "/attachments"
end
