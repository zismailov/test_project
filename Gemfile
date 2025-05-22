source "https://rubygems.org"

gem "rails", "~> 7.2.0"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "bootsnap", require: false
gem "kaminari"

group :development, :test do
  gem "debug", platforms: %i[mri mingw mswin x64_mingw], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'faker'
end

group :development do
  gem "web-console"
  gem "rubocop", "~> 1.57"
  gem "rubocop-rails", "~> 2.22"
  gem "rubocop-rspec", "~> 2.25"
  gem "rubocop-performance", "~> 1.20"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'rails-controller-testing'
end