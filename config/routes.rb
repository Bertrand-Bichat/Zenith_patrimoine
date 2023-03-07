Rails.application.routes.draw do

  # Devise
  devise_for :users

  # page d'accueil
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # pages
  get '/accueil', to: 'pages#home', as: :home
  get '/tableau-de-bord-admin/utilisateurs', to: 'pages#admin_dashboard_users', as: :admin_dashboard_users
  get '/tableau-de-bord-admin/criteres-de-tri', to: 'pages#admin_dashboard_criteria', as: :admin_dashboard_criteria
  get '/clients', to: 'pages#admin_dashboard_customers', as: :admin_dashboard_customers
  get '/instances', to: 'pages#client_files', as: :client_files
  get '/en-attente', to: 'pages#wait', as: :wait
  patch '/autorisation-utilisateur/:id', to: 'pages#user_authorized', as: :user_authorized
  patch '/assistant-utilisateur/:id', to: 'pages#user_assistant', as: :user_assistant
  patch '/admin-utilisateur/:id', to: 'pages#user_admin', as: :user_admin
  get '/adjoint/:id', to: 'pages#assistant', as: :assistant

  # criteria
  # post '/criteres-de-tri', to: 'criterions#create', as: :criterions
  # get '/criteres/:id/modifier', to: 'criterions#edit', as: :edit_criterion
  # patch '/criteres/:id', to: 'criterions#update', as: :criterion
  # put '/criteres/:id', to: 'criterions#update'
  # delete '/criteres/:id', to: 'criterions#destroy'

  # customers
  post '/nouveau-client', to: 'customers#create', as: :customers
  get '/clients/:id/modifier', to: 'customers#edit', as: :edit_customer
  patch '/clients/:id', to: 'customers#update', as: :customer
  put '/clients/:id', to: 'customers#update'

  # delegations
  post '/delegation', to: 'delegations#create', as: :delegations
  delete '/delegation/:id', to: 'delegations#destroy', as: :delegation

  # contracts
  post '/nouvelle-instance', to: 'contracts#create', as: :contracts
  patch '/instances/:id', to: 'contracts#update', as: :contract
  put '/instances/:id', to: 'contracts#update'
end
