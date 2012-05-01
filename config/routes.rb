Masqueunacasa::Application.routes.draw do
  devise_for :users

  # Rutas que se pueden acceder tanto desde un subdominio como sin él
  resources :users
  resources :posts


  # Rutas que sólo se puede acceder desde un subdominio
  constraints subdomain: /.+/ do
    match '', to: 'posts#index'
  end
  
  # Rutas sólo accesibles desde el dominio principal 
  constraints subdomain: /^$/ do
    resources :groups
    resources :posts
  end
  root to: 'dashboard#index'
  match "/enter/:id" => "users#enter", as: :enter unless Rails.env.production?  

  ActionDispatch::Routing::Translator.translate_from_file(
    'config/locales/routes.yml', prefix_on_default_locale: false )
end
