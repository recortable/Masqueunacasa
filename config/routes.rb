Masqueunacasa::Application.routes.draw do

  # Rutas que se pueden acceder tanto desde un subdominio como sin él
  resources :posts
  match '/entrar' => 'user_sessions#new', as: :login
  match '/salir' => 'user_sessions#destroy', as: :logout
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :messages, only: [:create, :show]


  # Rutas que sólo se puede acceder desde un subdominio
  constraints subdomain: /.+/ do
    match '', to: 'posts#index'
    resource :profile, only: [:show, :edit]
    resources :memberships
    resources :pages
    resources :groups, only: [:update, :show]
  end

  # Rutas sólo accesibles desde el dominio principal 
  constraints subdomain: /^$/ do
    resources :groups
    resources :posts
    resources :users
    resources :phases
    resources :proposals
    resources :versions
    resources :experiencies
  end

  root to: 'dashboard#welcome'

  match '/inicio' => 'dashboard#dashboard'
  match '/community' => 'dashboard#community', as: :community
  match '/cuatrocerocuatro' => 'dashboard#cuatrocerocuatro'
  match '/quinientos' => 'dashboard#quinientos'

  match "/enter/:id" => "users#enter", as: :enter 
  namespace :ckeditor do
    resources :pictures, :only => [:index, :create, :destroy]
    resources :attachment_files, :only => [:index, :create, :destroy]
    resources :attachments, :only => [:index, :create, :destroy]
  end

  ActionDispatch::Routing::Translator.translate_from_file(
    'config/locales/routes.yml', prefix_on_default_locale: false )
end
