
require "bundler/capistrano"

server "176.58.98.122", :web, :app, :db, primary: true

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

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/cloudinary.yml #{release_path}/config/cloudinary.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
namespace :backup do
  desc "Backup the database"
  task :db, :roles => :db do
    run "mkdir -p #{current_path}/backups"
    run "cd #{current_path}; pg_dump -U #{user} #{application}_production -f backups/#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.sql"
  end

  desc "Backup the database and download the script"
  task :download, :roles => :app do
    db
    timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S') 
    run "mkdir -p backups"
    run "cd #{current_path}; tar -cvzpf #{timestamp}_backup.tar.gz backups"
    get "#{current_path}/#{timestamp}_backup.tar.gz", "#{timestamp}_backup.tar.gz"
  end

  desc "Dumps target database into development db"
  task :sync_db do
    env   = ENV['RAILS_ENV'] || ENV['DB'] || 'production'
    file  = "#{application}.sql.bz2"
    remote_file = "#{shared_path}/log/#{file}"
    run "pg_dump --clean --no-owner --no-privileges -U#{db_user} -h#{db_host} #{db_name}_#{env} | bzip2 > #{file}" do |ch, stream, out|
      ch.send_data "#{db_password}\n" if out =~ /^Password:/
      puts out
    end
    puts rsync = "rsync #{user}@#{domain}:#{file} tmp"
    `#{rsync}`
    puts depackage = "bzcat tmp/#{file} | psql #{local_db_dev}"
    `#{depackage}`
  end
end

