package :mysql, :provides => :database do
  description 'MySQL Database'
  apt %w( mysql-server mysql-client libmysqlclient15-dev )

  verify do
    has_executable 'mysql'
  end
end
 
package :mysql_driver, :provides => :ruby_database_driver do
  description 'Ruby MySQL database driver'
  requires :ruby_enterprise, :mysql
  gem 'mysql'
  
  verify do
    has_gem 'mysql'
  end
end


package :postgresql, :provides => :database do
  description 'PostgreSQL database'
  apt %w( postgresql postgresql-client libpq-dev postgresql-server-dev-8.3 )
  
  verify do
    has_executable 'psql'
  end
end
 
package :postgresql_driver, :provides => :ruby_database_driver do
  description 'Ruby PostgreSQL database driver'
  gem 'postgres'
  requires :ruby_enterprise, :postgresql

  verify do
    has_gem 'postgres'
  end
end

