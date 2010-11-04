# Package is unstable and may not work properly.
package :redis do
  description 'Redis Database'
  version '2.0.3'
  s_ource "http://redis.googlecode.com/files/redis-#{version}.tar.gz"  # hack
  
  push_text '', "/tmp/sprinkle-hack" do
  # i don't know why but noop method did not work, it's a pure hack

    pre :install, "sudo mkdir -p /opt/redis"
    pre :install, "sudo mkdir -p /etc/redis"

    pre :install, "wget #{s_ource}"
    pre :install, "tar xvf redis-#{version}.tar.gz && cd redis-#{version} && make"

    # they have a typo in default configuration regarding pid-file
    pre :install, "cat redis-#{version}/redis.conf | sed 's/\\/var\\/run\\/redis.pid/\\/var\\/run\\/redis_6379.pid/' | sed 's/daemonize no/daemonize yes/' > r.conf"
    pre :install, "mv r.conf redis-#{version}/redis.conf"

    # they have an error in their init script as well
    pre :install, "cat redis-#{version}/utils/redis_init_script | sed '/SHUTDOWN/d' | sed 's/PID=$(cat $PIDFILE)/kill `cat $PIDFILE`/'> ris" 
    pre :install, "mv ris redis-#{version}/utils/redis_init_script"

    pre :install, "sudo mv redis-#{version}/redis-server /opt/redis/"
    pre :install, "sudo mv redis-#{version}/redis-cli /opt/redis/"
    pre :install, "sudo mv redis-#{version}/redis-benchmark /opt/redis/"
    pre :install, "sudo ln -s /opt/redis/redis-server /usr/local/bin"
    pre :install, "sudo ln -s /opt/redis/redis-cli /usr/local/bin"
    pre :install, "sudo ln -s /opt/redis/redis-benchmark /usr/local/bin"

    pre :install, "sudo mv redis-#{version}/utils/redis_init_script /etc/init.d/redis"
    pre :install, "sudo chmod +x /etc/init.d/redis"
    pre :install, "sudo mv redis-#{version}/redis.conf /etc/redis/6379.conf"

    post :install, "rm -rf redis-#{version}*"
    post :install, "sudo /usr/sbin/update-rc.d -f redis defaults"
    post :install, "sudo /etc/init.d/redis start"

  end

  verify do
    has_executable '/opt/redis/redis-server'
    has_file '/usr/local/bin/redis-server'
  end
end

