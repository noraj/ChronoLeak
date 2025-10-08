# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :runtime, :cli do
  gem 'logger', '< 2.0'
end

group :runtime, :lib do
  # none
end

group :development, :install do
  gem 'bundler', '~> 2.6'
end

group :development, :test do
  gem 'minitest', '~> 5.26'
  gem 'rake', '~> 13.3'
end

group :development, :debug do
  gem 'irb', '~> 1.15'
end

group :development, :lint do
  gem 'rubocop', '~> 1.81'
end
