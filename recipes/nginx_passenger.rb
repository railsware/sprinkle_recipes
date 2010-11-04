package :nginx, :provides => :webserver do
  description 'Nginx Web Server installed by Passenger'
  requires :passenger
  version = '0.7.65'
  apt %w( libcurl4-openssl-dev )

  flags = '--with-http_ssl_module --with-http_stub_status_module'

  push_text File.read(File.join(File.dirname(__FILE__), '..','nginx', 'init.d')), "/etc/init.d/nginx", :sudo => true do
    pre :install, "wget http://sysoev.ru/nginx/nginx-#{version}.tar.gz"
    pre :install, "tar xvf nginx-#{version}.tar.gz"

    pre :install, "sudo passenger-install-nginx-module --auto --nginx-source-dir=$HOME/nginx-#{version} --prefix=/opt/nginx --extra-configure-flags=\"#{flags}\""
    pre :install, "sudo ln -s /opt/nginx/conf /etc/nginx"

    post :install, "sudo chmod +x /etc/init.d/nginx"
    post :install, "sudo /usr/sbin/update-rc.d -f nginx defaults"
    post :install, "sudo /etc/init.d/nginx start"
  end

  verify do
    has_executable "/opt/nginx/sbin/nginx"
    has_file "/etc/init.d/nginx"
  end
end

package :passenger, :provides => :appserver do
  description 'Phusion Passenger (mod_rails)'
  version '2.2.10'

  binaries = %w(passenger-config
                passenger-install-nginx-module
                passenger-install-apache2-module
                passenger-make-enterprisey
                passenger-memory-stats 
                passenger-spawn-server 
                passenger-status
                passenger-stress-test)
  
  gem 'passenger', :version => version do    
    binaries.each {|bin| post :install, "ln -f -s #{REE_PATH}/bin/#{bin} /usr/local/bin/#{bin}"}
  end
  
  requires :ruby_enterprise
  
  verify do
    has_gem "passenger", version
    binaries.each { |bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  end
end

