# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.5.1'
gem 'i18n'

group :development do
  gem 'fasterer'
  gem 'pry'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'rspec'
  gem 'simplecov'
end
