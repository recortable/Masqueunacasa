require "bundler/capistrano"

load "config/recipes/all"

server "176.58.98.122", :web, :app, :db, primary: true
#server "198.199.73.200", :web, :app, :db, primary: true


set :application, "Masqueunacasa"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:recortable/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# nginx stuff
set :server_names, '<%= nginx_server_names %>'
set :nginx_page_caching, true

# newrelic settings
set :newrelic_license_key, '0a0d3776322392d64886579d8e72499290edd79a'

# config files settings
set :config_files, ['amazon_s3.yml', 'smtp.yml']

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :host, 'masqueunacasa.net'

after "deploy", "deploy:cleanup" # keep only the last 5 releases

