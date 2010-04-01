package :juggernaut, :provides => :comet do
  description 'Juggernaut Comet Server'
  version '0.5.8'
  gem "juggernaut"
  
  verify do
    has_gem "juggernaut"
  end
end

package :python do
  description 'Python language'
  apt %w( python python-dev python-setuptools )

  verify do
    has_file '/usr/bin/python'
    has_file '/usr/bin/easy_install'
  end
end

package :stomp_gem do
  description 'STOMP Server'
  version '1.1.4'
  gem "stomp"
  
  verify do
    has_gem "stomp"
  end
end

package :orbited, :provides => :comet_server do
  description 'Orbited comet server'
  requires :python

  push_text '', "/tmp/orbited-hack" do
    pre :install, "sudo easy_install twisted simplejson orbited"
  end

  verify do
    has_file '/usr/local/bin/orbited'
  end
end

package :erlang do
  description 'Erlang'
  apt %w( erlang-base erlang-nox erlang-src erlang-dev )
  verify do
    has_file '/usr/bin/erlc'
  end
end

package :rabbitmq_deps do
  description 'Erlang dependencies'
  apt %w( cdbs subversion zip )
end

package :rabbitmq, :provides => :ampq_server do
  description 'Rabbitmq AMPQ'
  requires :erlang
  requires :rabbitmq_deps

  apt "rabbitmq-server" do 
    pre :install, "wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc"
    pre :install, "sudo apt-key add rabbitmq-signing-key-public.asc"
    pre :install, 'echo "deb http://www.rabbitmq.com/debian/ testing main" | sudo tee -a /etc/apt/sources.list'
    pre :install, "sudo apt-get update"
  end

  verify do
    has_file '/usr/lib/rabbitmq/bin/rabbitmq-server'
  end
end

package :rabbitmq_stomp_plugin, :provides => :stomp_server do
  description 'Rabbitmq stomp plugin'
  requires :rabbitmq

  push_text '', "/tmp/rabbitmq_stomp-hack", :sudo => true do
    pre :install, "sudo hg clone http://hg.rabbitmq.com/rabbitmq-public-umbrella/ /opt/rabbitmq-public-umbrella"
    pre :install, "sudo make co -C /opt/rabbitmq-public-umbrella"
    pre :install, "sudo make -C /opt/rabbitmq-public-umbrella"
    pre :install, "sudo mkdir -p /usr/lib/rabbitmq/lib/rabbitmq_server-1.7.2/plugins"
    pre :install, "sudo cp /opt/rabbitmq-public-umbrella/rabbitmq-stomp/dist/rabbit_stomp.ez /usr/lib/rabbitmq/lib/rabbitmq_server-1.7.2/plugins"
    pre :install, "sudo rabbitmq-activate-plugins"
    pre :install, "echo SERVER_START_ARGS=\'-rabbit_stomp listeners \[\{\"0.0.0.0\",61613\}\]\' | sudo tee -a /etc/rabbitmq/rabbitmq.conf"
    pre :install, "sudo  service rabbitmq-server restart"
  end

  verify do
    has_file '/usr/lib/rabbitmq/lib/rabbitmq_server-1.7.2/priv/plugins/rabbit_stomp/ebin/rabbit_stomp.app'
  end
  
end

package :comet do
  description 'All comet stack'
  requires :rabbitmq_stomp_plugin
  requires :orbited
  requires :stomp_gem
end
