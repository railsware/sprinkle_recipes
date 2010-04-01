#Not sure if this recipe will work because exim has its own pseudo-gui installer
package :exim, :provides => :mailserver do
  description 'Exim MTA'
  apt 'exim4'

  verify do
    has_executable 'exim'
  end
end
