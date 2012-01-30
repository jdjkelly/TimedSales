default_run_options[:pty] = true 

set :application, "Timed Sales"
set :repository,  "git://github.com/jdjkelly/timedsales.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www"

role :web, "206.217.197.229"                          # Your HTTP server, Apache/etc
role :app, "206.217.197.229"                          # This may be the same as your `Web` server
role :db,  "206.217.197.229", :primary => true # This is where Rails migrations will run

set :user, "deploy"



# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end