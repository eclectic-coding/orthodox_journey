group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails", github: "thoughtbot/factory_bot_rails", ref: "refs/pull/495/head"
end

group :development do
  gem "fuubar", "~> 2.5", ">= 2.5.1"
end

group :test do
  gem "webmock"
  gem "simplecov", "~> 0.22.0", require: false
  gem "cuprite"
  gem "test-prof"
end
