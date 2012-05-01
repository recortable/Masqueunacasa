Masqueunacasa::Application.routes.draw do


  devise_for :users

  # Rutas que se pueden acceder tanto desde un subdominio como sin él
  resources :users
  resources :posts

  # Rutas que se pueden acceder desde el subdominio
  constraints subdomain: /^$/ do
    resources :groups
  end

  # Rutas que sólo se puede acceder desde un subdominio
  constraints subdomain: /.+/ do
    match '', to: 'posts#index'
  end
  root to: 'dashboard#index'

  ActionDispatch::Routing::Translator.translate_from_file(
    'config/locales/routes.yml', prefix_on_default_locale: false )
end
