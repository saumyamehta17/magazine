set :stages, ['staging','production']     #various environments
set :default_stage, "production"

#load "deploy/assets"                    #precompile all the css, js and images... before deployment..
# require 'capistrano/ext/multistage'     # deploy on all the servers..
#require 'airbrake/capistrano'

set :application, 'magazine'
set :repo_url, 'https://github.com/sweetymehta/magazine.git'
set :deploy_to, "/home/sweety/#{fetch(:application)}/#{fetch(:stage)}"
set :scm, :git

# set :delayed_job_args, "-n 2"            # number of delayed job workers
set :rvm_type, :user
# set :rvm_ruby_string, '2.2.2'             # ruby version you are using...
set :rvm_ruby_version, '2.2.2'
# server "45.55.144.140", [:app, :web, :db, :primary => true]
set :user, 'sweety'

set :use_sudo, true

set :branch, 'master'
set :keep_releases, 3

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true



# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
#set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


#before 'deploy:updated', 'db:configure'
namespace :db do
  task :copy_database_file do
    on roles :all do
      execute :ln, "-nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    end
    #run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end
  after "deploy", "db:copy_database_file"
end

#scp config/database.yml sweety@45.55.144.140:stack_flood/production/shared/config





