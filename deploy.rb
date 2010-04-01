# Fill host_address in
set :host_address, "127.0.0.1"

role :app, host_address
role :web, host_address
role :db,  host_address, :primary => true

# Fill user in - if remote user is different to your local user
set :user, "username"
#set :password, "password"
set :use_sudo, true

# Fill options below if you wish to use public/private-key auth instead of password one
#default_run_options[:pty] = true
#ssh_options[:user] = "root"
#ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/key.pem"]
