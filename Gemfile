source 'https://rubygems.org'
ruby '2.1.2'
gem 'rails', '4.0.2'

gem 'mysql2'

#group :production do
#  gem 'pg'
#  gem 'rails_12factor'
#end

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bcrypt-ruby', '~> 3.1.2'


gem 'simple_form', '~> 3.1.0.rc1',
    github: 'plataformatec/simple_form',
    branch: 'master'
gem 'less-rails'
gem 'twitter-bootstrap-rails',
    :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git',
    :branch => "bootstrap3"
gem 'devise'
gem 'cancan'
gem 'momentjs-rails', '>= 2.8.1'
gem 'bootstrap3-datetimepicker-rails', '~> 3.1.3'
gem 'activeadmin', github: 'activeadmin/active_admin'

gem 'paperclip'
gem 'aws-sdk'

gem 'state_machine'

#deployment
#gem 'puma'
group :production do
  #gem 'capistrano', require: false
  #gem 'capistrano-rvm', require: false
  #gem 'capistrano-rails', require: false
  #gem 'capistrano-bundler', require: false
  #gem 'capistrano3-puma', require: false
  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm', '~> 0.0.3'
  gem 'capistrano3-puma'
end