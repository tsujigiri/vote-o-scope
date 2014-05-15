source 'https://rubygems.org'

# Database adapters
gem 'sqlite3' unless ENV['CI']
gem 'mysql2' unless ENV['CI']
gem 'pg'

gem 'rails', '~> 4.0.3'

# Assets (JS, CSS, images)
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'handlebars_assets'
gem 'underscore-rails'
gem 'sass-rails'

# Authentification/authorization
gem 'devise'
gem 'cancancan'

# Misc.
gem 'acts_as_list'
gem 'active_model_serializers'

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'poltergeist'
end

group :debug do
  gem 'debugger'
end
