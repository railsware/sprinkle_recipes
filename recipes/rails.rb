package :rails do
  description 'Ruby on Rails'
  requires :ruby_enterprise
  gem 'rails'
  version '2.3.5'
  
  verify do
    has_gem 'rails'
  end
end
