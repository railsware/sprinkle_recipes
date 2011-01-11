package :goodies do
  description 'Different useful utilities required on the server'
  #Sysadmin tools
  apt %w(nmap netdiag htop mc screen vim ne wget sysstat fish zsh ccze pv logrotate rkhunter etckeeper) do

  end


  verify do
    has_file '/usr/sbin/trafshow'
    has_file '/usr/bin/nmap'
    has_file '/usr/bin/htop'
    has_file '/usr/bin/mc'
    has_file '/usr/bin/screen'
    has_file '/usr/bin/vim'
    has_file '/usr/bin/ne'
    has_file '/usr/bin/wget'
    has_file '/usr/bin/iostat'
    has_file '/usr/bin/fish'
    has_file '/usr/bin/zsh'
    has_file '/usr/bin/ccze'
    has_file '/usr/bin/pv'
    has_file '/usr/sbin/logrotate'
    has_file '/usr/bin/rkhunter'
    has_file '/usr/sbin/etckeeper'
  end
end
