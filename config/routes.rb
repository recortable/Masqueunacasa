Masqueunacasa::Application.routes.draw do

  # Rutas que sólo se puede acceder desde un subdominio
  constraints subdomain: /.+/ do
    match '', to: 'posts#index'
    resources :memberships
    resources :groups, only: [:update, :show]
  end

  # Rutas que se pueden acceder tanto desde un subdominio como sin él

  # PARTE SOCIAL
  constraints subdomain: /^$/ do
    match '/blog' => 'dashboard#blog'
  end
  resources :pages do
    resource :kudos
    resources :sections, except: [:index]
  end
  resources :posts do
    resource :kudos
    resources :post_attachments, except: [:index, :show]
  end
  resources :messages, only: [:create, :show]

  resource :profile, only: [:show, :edit]
  resources :announcements do
    put :send_email, on: :member
    put :probe, on: :member
  end

  match '/entrar' => 'user_sessions#new', as: :login
  match '/salir' => 'user_sessions#destroy', as: :logout
  match '/feed' => 'posts#feed', as: :feed, defaults: { format: 'atom' }
  match '/inicio' => 'dashboard#dashboard'
  match '/community' => 'dashboard#community', as: :community
  match '/cuatrocerocuatro' => 'dashboard#cuatrocerocuatro'
  match '/quinientos' => 'dashboard#quinientos'
  root to: 'dashboard#welcome'

  # Rutas sólo accesibles desde el dominio principal 
  constraints subdomain: /^$/ do
    resources :agents
    resources :users
    resources :versions
    resources :groups
    resources :sections, only: [:up, :down] do
      put :up, on: :member
      put :down, on: :member
    end

    # HABITAPEDIA
    resources :proposals, except: [:new] do
      resource :kudos
      put :up, on: :member
      put :down, on: :member
      resources :relations, only: [:new, :create, :destroy]
      resources :sections, except: [:index]
    end

    resources :experiencies do
      resource :kudos
      resources :sections, except: [:index]
    end


    resources :user_sessions, only: [:new, :create, :destroy]
    resources :password_recoveries
    resources :categories, only: [:index, :show] do
      resource :kudos
      resources :proposals, only: [:new]
      put :up, on: :member
      put :down, on: :member
      resources :sections, except: [:index]
    end
    resources :phases, except: [:show, :update, :destroy]
    # El path: '' es un truco para mostrar el nombre de las fases
    # sin el prefijo, es decir, en vez de "fases/mi_fase" 
    # se verá "mi_fase"
    resources :phases, only: [:show, :update, :destroy], path: '' do
      resource :kudos
      resources :sections, except: [:index]
      resources :categories, except: [:index]
    end

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
