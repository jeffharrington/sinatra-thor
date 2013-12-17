require 'thor'

class Sinatra < Thor
  include Thor::Actions

  desc "generate NAME", "Generates a new Sinatra application with name of 'NAME'"
  def generate(name)
    say "\nGenerating new Sinatra application called #{name}\n", :cyan
    create_directory name
    inside(name) do
      create_file "app.rb",         APP_RB
      create_file "config.ru",      CONFIG_RU
      create_file "environment.rb", ENVIRONMENT_RB
      create_file "Gemfile",        GEMFILE
      create_file "Procfile",       PROCFILE
      create_file ".gitignore",     GITIGNORE
      
      inside('config') do
        create_file "unicorn.rb", UNICORN_RB
      end
      
      inside('public/css') do
        create_file "application.css", APPLICATION_CSS
      end

      inside('public/js') do
        create_file "application.js", APPLICATION_JS
      end
      
      inside ('views') do
        create_file "index.erb", INDEX_ERB
      end

      inside('views/layouts') do
        create_file "application.erb", APPLICATION_ERB
      end      
      
      run "bundle install", capture: true # Hide output

      run "git init -q"
      run "git add ."
      run "git commit -qm 'Initial commit'"   
    end
    say "\nApplication successfully created!\n", :cyan
  end

  private

  def create_directory(path)
    say path, :yellow
    FileUtils.mkdir_p path
  end

#----------------------------------------------------------------------------
# File contents
#----------------------------------------------------------------------------
INDEX_ERB = "<h1>Hello, World!</h1>"

APPLICATION_CSS = "h1 { text-align: center; }"

APPLICATION_JS = "console.log('JavaScript Enabled');"

PROCFILE = "web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb"

APP_RB = <<-CONTENT
# Index
get '/' do
  erb :index
end
CONTENT

CONFIG_RU = <<-CONTENT
require './environment'
run Sinatra::Application
CONTENT

ENVIRONMENT_RB = <<-CONTENT
require 'sinatra'
require 'sinatra/reloader'
require 'rubygems' 
require 'bundler'  
Bundler.require

# Sync log output to STDOUT
$stdout.sync = true

# Set default layout for ERB
set :erb, :layout => :'layouts/application'

# Load the application
require_relative './app'
CONTENT

GEMFILE = <<-CONTENT
source 'https://rubygems.org'

ruby '2.0.0'

# Sinatra
gem 'sinatra'
gem 'sinatra-contrib'

# Webserver
gem 'unicorn'
CONTENT

GITIGNORE = <<-CONTENT
/.bundle
/log
/tmp
.DS_Store
CONTENT

UNICORN_RB = <<-CONTENT
worker_processes 3
timeout 30
preload_app true    
CONTENT

APPLICATION_ERB = <<-CONTENT
<!DOCTYPE html>
<html>
  <head>
    <title>Sinatra Application</title>
    <!-- CSS -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/application.css" />
    <!-- JS -->
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
    <script src="/js/application.js"></script>
  </head>
  <body>
    <div class='container'>
      <%= yield %>
    </div>
  </body>
</html>
CONTENT

end