
require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/postgresql_backup"
load "config/recipes/rbenv"
load "config/recipes/check"
load "config/recipes/assets"
load "config/recipes/config"

server "176.58.98.122", :web, :app, :db, primary: true

set :application, "Masqueunacasa"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:recortable/#{application}.git"
set :branch, "master"
set :config_files, ['database.yml', 'amazon_s3.yml', 'newrelic.yml', 'smtp.yml']

default_run_options[:pty] = true
ssh_options[:forward_agent] = true


after "deploy", "deploy:cleanup" # keep only the last 5 releases

