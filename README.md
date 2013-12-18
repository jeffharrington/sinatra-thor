# Sinatra Thor 

Thor script to generate a skeleton Sinatra application

## Background

I love [Sinatra](http://www.sinatrarb.com) and the minimalist philosophy it embodies. 

However, I felt that frameworks like [Monk](https://github.com/monkrb/monk) or [Padrino](http://www.padrinorb.com/) take away from that minimalist feel. 

So I created a (minimal) script using [Thor](http://whatisthor.com/) to generate a skeleton Sinatra application to my liking. 

## Description

This Thor script will generate a minimalist Sinatra application. 

The application that is generated includes the following Gems:

* [sinatra](http://rubygems.org/gems/sinatra)
* [sinatra-contrib](http://rubygems.org/gems/sinatra-contrib)
* [unicorn](http://rubygems.org/gems/unicorn)

And sets up the following front-end frameworks 

* [jQuery](http://jquery.com/)
* [Bootstrap](http://getbootstrap.com/)

Finally, the script will automatically install gems via Bundler and initialize a Git repository. 

## Requirements

* [Ruby](https://www.ruby-lang.org/en/)
* [Git](http://git-scm.com/)
* [Thor](http://whatisthor.com/)
* [Bundler](http://bundler.io/)

## Install

Clone the repository to your local machine:

    git clone https://github.com/jeffharrington/sinatra-thor.git

Change to the directory of the project and run:

    thor install sinatra.thor

After going through the installation process, you will now see the task installed when you run:

    thor installed

## Usage

Execute the script using Thor as follows:

    thor sinatra:generate YOUR_APPLICATION_NAME

This will generate a new Sinatra application with the following folder structure:

* config/
  * unicorn.rb
* public/
  * css/
    * application.css
  * js/
    * application.js
* views/
  * layouts/
    * application.erb
  * index.erb
* .gitignore
* app.rb
* config.ru
* environment.rb
* Gemfile
* Procfile




