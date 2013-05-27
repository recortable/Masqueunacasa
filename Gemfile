source 'https://rubygems.org'

gem 'rails', '>= 3.2'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'
  gem 'font-awesome-sass-rails'
end

# Cosas de modelos
gem 'bcrypt-ruby', '~> 3.0.0' # Para encriptar cosas, p.ej: password (MD5)
gem 'friendly_id'
gem 'acts_as_list'
gem 'texticle', '~> 2.0'#, :require => 'texticle/rails'
gem 'globalize3'

# Para subir ficheros e imágenes al servidor
gem "mini_magick" # Para modificar imágenes (lo usa carrierwave)
gem 'fog'
gem 'carrierwave'
#gem 'cloudinary'
gem 'mini_magick'

# Cosas de controladores
gem 'decent_exposure', '1.0.2'
gem 'cancan'
gem 'routing_concerns'

# Cosas de vistas
gem 'wax_museum', git: 'git://github.com/recortable/wax_museum.git' # Páginas estáticas
gem 'cache_digests'
gem 'jquery-rails' # Integración de jquery y rails
gem 'jquery-ui-rails'
gem 'will_paginate-bootstrap' # Integración will_paginate - twitter bootstrap
gem 'will_paginate', '~> 3.0'
gem 'hpricot'
gem 'nested_form'
# gem "ckeditor" # Editor RTE
#gem 'bootstrap-wysihtml5-rails'
gem 'jbuilder' # Para enviar json fácilmente
gem 'ie_conditional_tag' # Para meter el html tag con clases especiales según la version de explorer
gem 'truncate_html' # Para poder recortar un texto en html sin que se estropee la estructura
gem 'htmlentities'
#gem 'roadie' # P#ara meter css en los emails
gem 'premailer-rails3'
gem "breadcrumbs_on_rails"
gem 'bourbon' #Colección de mixins para SASS

gem 'simple_form'
gem 'redcarpet' # Convierte markdown a html
gem 'cambelt' # Genera imágenes de prueba
gem 'basic_config' # https://github.com/stephan778/basic_config 
gem 'turbolinks'

gem 'rails-translate-routes'
gem 'http_accept_language'

gem 'hoptoad_notifier'

gem 'unicorn'
gem 'capistrano'
gem 'newrelic_rpm'

group :development do
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'thin'
  gem 'hirb'  ## Nice db outputs on rails console. Enable with Hirb.enable

  ## http://railscasts.com/episodes/402-better-errors-railspanel
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec', '0.5.5'
  gem 'rb-inotify', '~> 0.8.8', require: RUBY_PLATFORM.include?('linux') && 'rb-inotify'
  gem 'terminal-notifier-guard', require: RUBY_PLATFORM.include?('darwin') && 'terminal-notifier-guard'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'spork', '0.9.0'
  gem 'guard-spork', '0.3.2'
  gem 'factory_girl_rails'
end
