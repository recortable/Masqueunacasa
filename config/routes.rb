require 'sidekiq/web'
require 'sidetiq/web'
require 'admin_constraint'

Masqueunacasa::Application.routes.draw do
  # CONCERNS
  concern :document do
    resource :kudos
  end

  concern :commentable do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  # PARTE SOCIAL
  resources :users, except: [:index]
  resources :groups, except: [:index] do
    resources :memberships, only: [:index, :create, :destroy]
  end

  # GENERAL

  resources :locations, only: [:index]

  match '/entrar' => 'user_sessions#new', as: :login
  match '/salir' => 'user_sessions#destroy', as: :logout
  match '/community' => 'dashboard#community', as: :community
  match '/cuatrocerocuatro' => 'dashboard#cuatrocerocuatro'
  match '/quinientos' => 'dashboard#quinientos'
  match "/enter/:id" => "users#enter", as: :enter
  get '/admin/' => 'dashboard#admin_area', as: :admin_area
  get '/search' => 'searches#show', as: :search

  root to: 'dashboard#welcome'

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_recoveries

  # HABITAPEDIA

  resources :experiencies, concerns: [:document, :commentable]

  resources :phases, except: [:destroy] do
    resources :categories, except: [:index, :new, :create]
  end

  resources :categories, only: [:show, :new, :create], concerns: [:document, :commentable] do
    resources :proposals, only: [:new]
  end

  resources :proposals, except: [:index, :new], path: '/phases/proposals', concerns: [:document, :commentable] do
    resources :relations, only: [:new, :create, :destroy]
  end

  # ADMINISTRACIÓN

  resources :help_texts, except: [:index]
  resources :help_pages, except: [:index]

  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', {
    prefix_on_default_locale: true }) # para permitir poner el idioma de la página
                                      # en función de las preferencias del navegador.

  # Rutas para el preview del editor de texto enriquecido
  mount Markitup::Rails::Engine, at: "markitup", as: "markitup"

  # Ruta para la interfaz web de sidekiq
  mount Sidekiq::Web, at: '/sidekiq', constraints: AdminConstraint.new

  # Para dar soporte a las rutas antiguas, que no tenian el parámetro con el locale en
  # el idioma por defecto
  match ":locale/*path" => 'application#set_locale'
  match "*path" => 'application#set_locale'
end

