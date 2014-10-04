# config valid only for Capistrano 3.1
require 'capistrano/setup'
require 'capistrano/deploy'
require "capistrano/bundler"
require 'capistrano/rails'
require "capistrano/rvm"


# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
require "capistrano/puma"

set :rails_env, 'production'
set :user, 'dev'
set :use_sudo, true

set :application, 'lifebuoy_school'
set :repo_url, 'git@github.com:rakib063049/LifeBoySchool.git'
set :branch, :capistrano

set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"

set :scm, :git
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, {path: "/usr/local/bin:$PATH"}

set :keep_releases, 3
set :default_shell, '/bin/bash -l'

set :rbenv_ruby, '2.1.2p95'
set :bundle_bins, %w("bundle exec")
set :rvm_map_bins, %w{gem rake ruby bundle}
set :bundle_roles, :app
set :migration_role, :db
set :assets_roles, %w{app}

set :log_level, :debug


set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock" #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true
set :puma_prune_bundler, false

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  after :finishing, :compile_assets
  #after :finishing, :cleanup
  after :finishing, :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
# sudo ln -nfs /home/dev/lifebuoy_school/current/config/nginx.conf /etc/nginx/sites-enabled/lifebuoy_school
