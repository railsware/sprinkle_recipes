package :ruby_enterprise do
  description 'Ruby Enterprise Edition'
  requires :ree_dependencies
  version '1.8.7-2010.01'
  REE_PATH = "/usr/local/ruby-enterprise"

  binaries = %w(erb gem irb rackup rails rake rdoc ree-version ri ruby testrb)
  source "http://rubyforge.org/frs/download.php/68719/ruby-enterprise-#{version}.tar.gz" do
    custom_install 'sudo ./installer --auto=/usr/local/ruby-enterprise'
    post :install, "mkdir -p /usr/local/bin"
    binaries.each {|bin| post :install, "ln -s #{REE_PATH}/bin/#{bin} /usr/local/bin/#{bin}" }
  end
  
  verify do
    has_directory install_path
    has_executable "#{REE_PATH}/bin/ruby"
    binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  end  
end

package :ree_dependencies do 
  apt %w(zlib1g-dev libreadline5-dev libssl-dev)
  requires :essentials
end

package :rubygems do
  description 'Ruby Gems Package Management System'
  version '1.3.6'
  requires :ruby_enterprise

  source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz" do
    custom_install 'ruby setup.rb'
  end
end
