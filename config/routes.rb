Masqueunacasa::Application.routes.draw do
  # CONCERNS
  concern :document do
    resource :kudos
    resources :sections, except: [:index]
    resource :edition
  end

  concern :locations do
    resources :locations, except: [:index, :show]
  end

  concern :position do
    put :up, on: :member
    put :down, on: :member
  end

  # PARTE SOCIAL
  resources :users, concerns: [:locations]
  resources :groups, concerns: [:locations] do
    resources :memberships, only: [:new, :create, :destroy]
  end

  # GENERAL
  resources :images, only: [:up, :down], concerns: :position do
  end

  resources :locations
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

  root to: 'phases#index'
  WaxMuseum::Routes.draw

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_recoveries

  resources :notices, concerns: [:position]

  # HABITAPEDIA

  resources :experiencies, concerns: [:document] do
    get :dashboard, on: :collection
    resources :locations
    resources :links
    resources :images
  end


  resources :categories, only: [:show], concerns: [:document, :position] do
    get :dashboard, on: :collection
    resources :proposals, only: [:new]
  end

  resources :proposals, except: [:new], path: '/phases/proposals', concerns: [:document, :position] do
    get :dashboard, on: :collection
    resources :relations, only: [:new, :create, :destroy]
    resources :links
  end

  resources :phases, except: [:show, :update, :destroy]

  resources :phases, only: [:show, :update, :destroy], concerns: [:document] do
    resources :categories, except: [:index], path: ''
  end

  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', {
    prefix_on_default_locale: true }) # para permitir poner el idioma de la página
                                      # en función de las preferencias del navegador.

  # Para dar soporte a las rutas antiguas, que no tenian el parámetro con el locale en
  # el idioma por defecto
  match ":locale/*path" => 'application#set_locale'
  match "*path" => 'application#set_locale'
end
