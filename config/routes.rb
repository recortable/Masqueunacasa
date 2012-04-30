Masqueunacasa::Application.routes.draw do

  constraints subdomain: /.+/ do
    match '', to: 'space/groups#show'
    namespace :space do
      root to: 'groups#show'
    end
  end

  devise_for :users
  resources :groups
  resources :users

  root to: 'dashboard#index'

  ActionDispatch::Routing::Translator.translate_from_file(
    'config/locales/routes.yml', prefix_on_default_locale: false )
end
