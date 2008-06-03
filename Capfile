load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do
  # Joyent recommend starting and monitoring Rails processes as "Bootup Actions".
  # From my experimentation, it seems like trying to spawn Mongrel via Capistrano
  # in the usual way interferes with (and is interfered with by) these Bootup
  # Actions. So, I'm disabling start and overriding restart to just do a "stop".
  # The Solaris Bootup Action will notice when Mongrel dies and restart it 
  # immediately.
  desc 'Start the application servers.'
  task :start do
    puts 'To start the application, please use the Bootup Actions at'
    puts 'https://virtualmin.joyent.us/woodward/virtualmin-init/index.cgi?dom=120695737911739'
  end
  
  desc 'Restarts your application.'
  task :restart do
    stop
  end
  
  desc 'Stop the application servers.'
  task :stop, :roles => :app do
    as = fetch(:runner, "app")
    via = fetch(:run_method, :sudo)
    invoke_command "#{current_path}/script/process/reaper -a kill", :via => via, :as => as
  end
end
