package :essentials do
  description 'Build tools required for building linux apps from source'
  apt 'build-essential' do
    pre :install, 'sudo apt-get update'
  end
end

