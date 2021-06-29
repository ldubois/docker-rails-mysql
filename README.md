# docker-rails-mysql

Docker paraméter pour lancer des projets ruby. Actuellemnt en version 2.6.3, le script est modifiable à souhait.

## Installation & Lancement

* docker-compose build
* docker-compose run app bundle rake db:migrate
* docker-compose d

## Configuration

environnements/developpement.rb, add for yarn version :
```ruby
config.webpacker.check_yarn_integrity = false
```
initializers/assets.rb, add for fix problem with windows environnement :
```ruby
Rails.application.config.assets.configure do |env|
    env.cache = Sprockets::Cache::FileStore.new(
      ENV.fetch("SPROCKETS_CACHE", "#{env.root}/tmp/cache/assets"),
      Rails.application.config.assets.cache_limit,
      env.logger
    )
  end
```
database.yml :
```ruby
default: &default
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  adapter: mysql2
  encoding: utf8
  host: <%= ENV['DB_HOST'] %> 
  database: <%= ENV['DB_NAME'] %> 
  username: <%= ENV['DB_USER'] %> 
  password: <%= ENV['DB_PASSWORD'] %> 

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: db/test.sqlite3

production:
  <<: *default
  adapter: mysql2
  encoding: utf8
  host: <%= ENV['DB_HOST'] %> 
  database: <%= ENV['DB_NAME'] %> 
  username: <%= ENV['DB_USER'] %> 
  password: <%= ENV['DB_PASSWORD'] %> 

```