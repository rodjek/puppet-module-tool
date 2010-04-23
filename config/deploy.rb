# General settings
set :application, "modulesite"
set :use_sudo, false
ssh_options[:compression] = false
default_run_options[:pty] = true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

desc "Make symlink for database yaml"
before 'deploy:finalize_update', :symlink_database_yml

task :symlink_database_yml do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
end