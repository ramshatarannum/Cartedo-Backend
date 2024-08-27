# config/routes.rb
Rails.application.routes.draw do
  post '/api/register', to: 'users#create'
  post '/api/login', to: 'users#login'
  post '/api/tasks', to: 'tasks#create'
  post '/api/tasks/:id/assign', to: 'tasks#assign'
  get '/api/tasks/assigned', to: 'tasks#assigned'
  patch '/api/tasks/:id/complete', to: 'tasks#complete'
end
