source 'https://rubygems.org'
ruby '2.1.2'
gem 'rails', '4.0.2'

group :development do
  gem 'mysql2'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

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
group :development do
  gem 'capistrano-ext'
  gem 'capistrano', '~> 3.2.0'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-puma'
end