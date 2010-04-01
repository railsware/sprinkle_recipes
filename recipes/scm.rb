package :mercurial, :provides => :scm do
  description 'Mercurial Distributed Version Control'
  apt 'mercurial' 

  verify do
    has_file '/usr/bin/hg'
  end
end

package :git, :provides => :scm do
  description 'Git Distributed Version Control'
  apt 'git-core'

  verify do
    has_file '/usr/bin/git'
  end
end

