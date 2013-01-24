Masqueunacasa::Application.routes.draw do
  # CONCERNS 
  concern :document do
    resource :kudos
    resources :sections, except: [:index]
    resource :edition
    get 'supereditor' => "editions#edit"
  end

  concern :position do
    put :up, on: :member
    put :down, on: :member
  end

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
  resources :pages, concerns: [:document]

  resources :posts, concerns: [:document] do
    get :dashboard, on: :collection
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
  resources :images, only: [:up, :down], concerns: :position do
  end
  resources :sections, only: [:up, :down, :remove_image], concerns: :position do
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
  match '/activity_mail' => 'dashboard#activity_mail'
  match "/enter/:id" => "users#enter", as: :enter 
  match '/mail/:action/' => 'mailer'
  match '/buscar/' => 'dashboard#search', as: :seach

  root to: 'dashboard#welcome'
  WaxMuseum::Routes.draw

  # Rutas sólo accesibles desde el dominio principal 
  constraints subdomain: /^$/ do
    resources :user_sessions, only: [:new, :create, :destroy]
    resources :password_recoveries

    resources :notices, concerns: [:position]
    resources :agents
    resources :groups do
      resources :sections
      resources :kudos
      resources :memberships
      resources :locations
    end
    resources :versions


    # HABITAPEDIA

    resources :experiencies, concerns: [:document] do
      get :dashboard, on: :collection
      resources :locations
      resources :links
      resources :subscribers, only: [:create, :destroy]
      resources :images
    end


    resources :categories, only: [:show], concerns: [:document, :position] do
      get :dashboard, on: :collection
      resources :proposals, only: [:new]
      resources :subscribers, only: [:create, :destroy]
    end

    resources :proposals, except: [:new], path: '/phases/proposals', concerns: [:document, :position] do
      get :dashboard, on: :collection
      resources :relations, only: [:new, :create, :destroy]
      resources :subscribers, only: [:create, :destroy]
      resources :links
    end

    resources :phases, except: [:show, :update, :destroy]

    resources :phases, only: [:show, :update, :destroy], concerns: [:document] do
      resources :categories, except: [:index], path: ''
      resources :subscribers, only: [:create, :destroy]
    end
  end

  match "*path" => 'application#set_locale'

  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { 
    prefix_on_default_locale: true,
    keep_untranslated_routes: true})
end
