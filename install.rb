# Require our stack
%w(goodies essentials ruby_ee_dep_gems scm rails databases nginx_passenger geoip comet redis imagemagick mailserver).each do |r|
  require File.join(File.dirname(__FILE__), 'recipes', r)
end

policy :stack, :roles => :app do
  requires :goodies               # Different utilities for system administrator like htop, screen, vim, ccze, logrotate, etc
  requires :webserver             # Nginx
  requires :appserver             # Passenger for Nginx
  requires :database              # MySQL or Postgres with appropriate ruby gems
  requires :scm                   # Git or Mercurial
  requires :rails                 # Latest stable version of Ruby on Rails
  #requires :comet                 # Comet server of you choice: Juggernaut or Orbited/RabbitMQ
  requires :geoip                 # GeoIP C library and free GeoIP City database
  #requires :redis                 # Redis database, recipe is not stable and not recomended to use at this time
  requires :imagemagick           # ImageMagick utility
  #requires :mailserver           # Mail server. Not used by default because Ubuntu is already shipped with Exim4
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    begin
      recipes 'Capfile'
    rescue LoadError
      recipes 'deploy'
    end
  end
  # source based package installer defaults
  source do
    prefix   '/opt'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end

# Depend on a specific version of sprinkle 
begin
  gem 'sprinkle', ">= 0.2.1" 
rescue Gem::LoadError
  puts "sprinkle 0.2.1 required.\n Run: `sudo gem install sprinkle`"
  exit
end

