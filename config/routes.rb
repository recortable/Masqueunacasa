Masqueunacasa::Application.routes.draw do

  # Rutas que se pueden acceder tanto desde un subdominio como sin él
  resources :posts
  match '/entrar' => 'user_sessions#new', as: :login
  match '/salir' => 'user_sessions#destroy', as: :logout
  match '/feed' => 'posts#feed', as: :feed, defaults: { format: 'atom' }
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :messages, only: [:create, :show]


  # Rutas que sólo se puede acceder desde un subdominio
  constraints subdomain: /.+/ do
    match '', to: 'posts#index'
    resource :profile, only: [:show, :edit]
    resources :memberships
    resources :pages
    resources :groups, only: [:update, :show]
    resources :announcements do
      put :send_email, on: :member
      put :probe, on: :member
    end

  end

  root to: 'dashboard#welcome'
  match '/inicio' => 'dashboard#dashboard'
  match '/community' => 'dashboard#community', as: :community
  match '/cuatrocerocuatro' => 'dashboard#cuatrocerocuatro'
  match '/quinientos' => 'dashboard#quinientos'

  # Rutas sólo accesibles desde el dominio principal 
  constraints subdomain: /^$/ do
    resources :groups
    resources :posts
    resources :users
    resources :versions
    resources :proposals do
      resources :relations, only: [:new, :create, :destroy]
    end
    resources :experiencies


    # Esto es un truco para mostrar el nombre de las fases
    # sin el prefijo, es decir, en vez de "fases/mi_fase" 
    # se verá "mi_fase"
    resources :phases, except: [:show, :update, :destroy]
    resources :phases, only: [:show, :update, :destroy], path: '' do
      resources :categories, except: [:index]
    end

    resources :password_recoveries
  end


  match "/enter/:id" => "users#enter", as: :enter 
  namespace :ckeditor do
    resources :pictures, :only => [:index, :create, :destroy]
    resources :attachment_files, :only => [:index, :create, :destroy]
    resources :attachments, :only => [:index, :create, :destroy]
  end

  ActionDispatch::Routing::Translator.translate_from_file(
    'config/locales/routes.yml', prefix_on_default_locale: false )
end
