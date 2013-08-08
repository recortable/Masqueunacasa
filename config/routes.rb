Masqueunacasa::Application.routes.draw do
  # CONCERNS
  concern :document do
    resource :kudos
    resources :sections, except: [:index]
    resource :edition
  end

  concern :commentable do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  concern :position do
    put :up, on: :member
    put :down, on: :member
  end

  # PARTE SOCIAL
  resources :users
  resources :groups do
    resources :memberships, only: [:index, :create, :destroy]
  end

  # GENERAL
  resources :images, only: [:up, :down], concerns: :position do
  end

  resources :locations, only: [:index]

  resource :search

  match '/entrar' => 'user_sessions#new', as: :login
  match '/salir' => 'user_sessions#destroy', as: :logout
  match '/inicio' => 'dashboard#dashboard'
  match '/community' => 'dashboard#community', as: :community
  match '/cuatrocerocuatro' => 'dashboard#cuatrocerocuatro'
  match '/quinientos' => 'dashboard#quinientos'
  match "/enter/:id" => "users#enter", as: :enter
  match '/mail/:action/' => 'mailer'
  match '/buscar/' => 'dashboard#search', as: :seach
  get '/admin/' => 'dashboard#admin_area', as: :admin_area

  root to: 'dashboard#welcome'
  WaxMuseum::Routes.draw

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_recoveries

  resources :notices, concerns: [:position]

  # HABITAPEDIA

  resources :experiencies, concerns: [:document, :commentable] do
    get :dashboard, on: :collection
    resources :links
    resources :images
  end


  resources :categories, only: [:show, :new, :create], concerns: [:document, :position, :commentable] do
    get :dashboard, on: :collection
    resources :proposals, only: [:new]
  end

  resources :proposals, except: [:new], path: '/phases/proposals', concerns: [:document, :position, :commentable] do
    get :dashboard, on: :collection
    resources :relations, only: [:new, :create, :destroy]
    resources :links
  end

  resources :phases, except: [:show, :update, :destroy]

  resources :phases, only: [:show, :update, :destroy], concerns: [:document] do
    resources :categories, except: [:index, :new, :create], path: ''
  end

  # ADMINISTRACIÓN

  resources :help_texts, except: [:index]
  resources :help_pages, except: [:index]

  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', {
    prefix_on_default_locale: true }) # para permitir poner el idioma de la página
                                      # en función de las preferencias del navegador.

  # Rutas para el preview del editor de texto enriquecido
  mount Markitup::Rails::Engine, at: "markitup", as: "markitup"

  # Para dar soporte a las rutas antiguas, que no tenian el parámetro con el locale en
  # el idioma por defecto
  match ":locale/*path" => 'application#set_locale'
  match "*path" => 'application#set_locale'
end
