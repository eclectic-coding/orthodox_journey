gem "annotate"
gem "cssbundling-rails"
gem "inline_svg"
gem "name_of_person"
# gem "strong_migrations"
gem "devise"
gem "pundit"
gem "view_component"
gem "dry-initializer"
gem "sidekiq"

group :development, :test do
  gem "erb_lint"
  gem "faker"
end

group :development do
  gem "bundle-audit", require: false
  # gem "bullet" # Uncomment if you want to use Bullet (doesn't support Rails beta)
  gem "letter_opener_web"
  gem "rails-erd"
end
