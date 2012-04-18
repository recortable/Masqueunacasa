Masqueunacasa::Application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  resources :groups
  resources :users

  ActionDispatch::Routing::Translator.translate_from_file(
    'config/locales/routes.yml', prefix_on_default_locale: true )
end
