Masqueunacasa::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  # Rutas que se pueden acceder tanto desde un subdominio como sin él
  resources :posts
  match '/entrar' => 'user_sessions#new', as: :login
  match '/salir' => 'user_sessions#destroy', as: :logout
  resources :user_sessions, only: [:new, :create, :destroy]


  # Rutas que sólo se puede acceder desde un subdominio
  constraints subdomain: /.+/ do
    match '', to: 'posts#index'
    resource :profile
    resources :memberships
    resources :pages
  end

  # Rutas sólo accesibles desde el dominio principal 
  constraints subdomain: /^$/ do
    resources :groups
    resources :posts
    resources :users
    resources :phases
    resources :proposals
    resources :versions
  end
  root to: 'dashboard#index'
  match "/enter/:id" => "users#enter", as: :enter 

  ActionDispatch::Routing::Translator.translate_from_file(
    'config/locales/routes.yml', prefix_on_default_locale: false )
end
