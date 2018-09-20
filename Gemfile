source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'webpacker'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'redis', '~> 4.0'
gem 'bcrypt', '~> 3.1.7'

gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'minitest-rails'
  gem 'simplecov', require: false
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'mocha'
  gem 'minitest-reporters'
  gem 'webmock'
end

gem 'devise'
gem 'sidekiq'
gem 'slim-rails'
gem 'formtastic'
gem 'rollbar'
gem 'foreman'
gem 'pundit'
gem 'high_voltage'
gem 'draper'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
