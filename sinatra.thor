require 'thor'

class Sinatra < Thor
  include Thor::Actions

  desc "generate NAME", "Generates a new Sinatra application with name of 'NAME'"
  def generate(name)
    say "\nGenerating new Sinatra application called #{name}\n", :cyan
    create_directory name
    inside(name) do
      create_file "app.rb",         content_for_app_rb
      create_file "config.ru",      content_for_config_ru
      create_file "environment.rb", content_for_environment_rb
      create_file "Gemfile",        content_for_gemfile
      create_file "Procfile",       content_for_procfile
      create_file ".gitignore",     content_for_gitignore
      
      inside('config') do
        create_file "unicorn.rb", content_for_unicorn_rb
      end
      
      inside('public/css') do
        create_file "application.css", content_for_application_css
      end

      inside('public/js') do
        create_file "application.js", content_for_application_js
      end
      
      inside ('views') do
        create_file "index.erb", content_or_index_erb
      end

      inside('views/layouts') do
        create_file "application.erb", content_for_application_erb
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
def content_or_index_erb
<<-INDEX_ERB
<h1>Hello, World!</h1>
<span class='glyphicon glyphicon-globe'></span>
INDEX_ERB
end

def content_for_app_rb
<<-APP_RB
# Index
get '/' do
  erb :index
end
APP_RB
end

def content_for_config_ru
<<-CONFIG_RU
require './environment'
run Sinatra::Application
CONFIG_RU
end

def content_for_environment_rb
<<-ENVIRONMENT_RB
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
ENVIRONMENT_RB
end

def content_for_gemfile
<<-GEMFILE
source 'https://rubygems.org'

ruby '2.0.0'

# Sinatra
gem 'sinatra'
gem 'sinatra-contrib'

# Webserver
gem 'unicorn'
GEMFILE
end

def content_for_procfile
"web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb"
end

def content_for_gitignore
<<-GITIGNORE
/.bundle
/log
/tmp
.DS_Store
GITIGNORE
end

def content_for_unicorn_rb
<<-UNICORN_RB
worker_processes 3
timeout 30
preload_app true    
UNICORN_RB
end

def content_for_application_css
<<-APPLICATION_CSS
.container { text-align: center; }
.glyphicon-globe { color: green; font-size: 3em;}
APPLICATION_CSS
end

def content_for_application_js
<<-APPLICATION_JS
console.log('JavaScript Enabled');
APPLICATION_JS
end

def content_for_application_erb
<<-APPLICATION_ERB
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
APPLICATION_ERB
end

end