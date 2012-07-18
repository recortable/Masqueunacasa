Masqueunacasa::Application.routes.draw do

  # Rutas que sólo se puede acceder desde un subdominio
  constraints subdomain: /.+/ do
    match '', to: 'groups#root'
    resources :groups, only: [:update, :show] do
      resources :sections
    end
  end

  # Rutas que se pueden acceder tanto desde un subdominio como sin él

  # PARTE SOCIAL
  resources :users do
    resources :sections
    resources :kudos
    resources :locations
  end
  resources :pages do
    resource :kudos
    resources :sections, except: [:index]
  end
  resources :posts do
    resources :sections, except: [:index]
    resource :kudos
    resources :post_attachments, except: [:index, :show]
  end
  resources :messages, only: [:create, :show]
  resources :memberships, only: [:new, :create, :destroy]

  resource :profile, only: [:show, :edit] 

  resources :announcements do
    put :send_email, on: :member
    put :probe, on: :member
  end

  # GENERAL
  resources :images, only: [:up, :down] do
    put :up, on: :member
    put :down, on: :member
  end
  resources :sections, only: [:up, :down, :remove_image] do
    put :up, on: :member
    put :down, on: :member
    delete :remove_image, on: :member
  end
  match '/mapa' => 'locations#map', as: :map
  resources :locations
  resource :search

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
    resources :groups do
      resources :sections
      resources :kudos
      resources :memberships
      resources :locations
    end
    resources :versions


    # HABITAPEDIA
    resources :proposals, except: [:new] do
      resource :kudos
      put :up, on: :member
      put :down, on: :member
      resource :edition
      resources :relations, only: [:new, :create, :destroy]
      resources :sections, except: [:index]
      resources :subscribers, only: [:create, :destroy]
      resources :links
      resources :tasks
    end

    resources :experiencies do
      resource :kudos
      resources :sections, except: [:index]
      resources :locations
      resources :links
      resource :edition
      resources :subscribers, only: [:create, :destroy]
      resources :tasks
      resources :images
    end


    resources :user_sessions, only: [:new, :create, :destroy]
    resources :password_recoveries
    resources :categories, only: [:index, :show] do
      resource :kudos
      resources :proposals, only: [:new]
      put :up, on: :member
      put :down, on: :member
      resources :sections, except: [:index]
      resources :subscribers, only: [:create, :destroy]
      resources :tasks
      resource :edition
    end
    resources :phases, except: [:show, :update, :destroy]
    # El path: '' es un truco para mostrar el nombre de las fases
    # sin el prefijo, es decir, en vez de "fases/mi_fase" 
    # se verá "mi_fase"
    resources :phases, only: [:show, :update, :destroy], path: '' do
      resource :kudos
      resources :sections, except: [:index]
      resources :categories, except: [:index]
      resource :edition
      resources :subscribers, only: [:create, :destroy]
    end

  end


  match "/enter/:id" => "users#enter", as: :enter 
  namespace :ckeditor do
    resources :pictures, :only => [:index, :create, :destroy]
    resources :attachment_files, :only => [:index, :create, :destroy]
    resources :attachments, :only => [:index, :create, :destroy]
  end

  #ActionDispatch::Routing::Translator.translate_from_file(
  #  'config/locales/routes.yml', prefix_on_default_locale: false )
end
