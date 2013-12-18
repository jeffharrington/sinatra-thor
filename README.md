# Sinatra Thor 

Thor script to generate a skeleton Sinatra application

## Background

I love Sinatra and the minimalist philosophy it embodies. 

However, I felt that frameworks like Monk or Padrino take away from that minimalist feel. 

So I created a (minimal) script using Thor to generate a skeleton Sinatra application to my liking. 

## Description

This Thor script will generate a minimalist Sinatra application. 

The application that is generated includes the following Gems:

* sinatra
* sinatra-contrib
* unicorn

And sets up the following front-end frameworks 

* jQuery
* Bootstrap

Finally, the script will automatically install gems via Bundler and initialize a Git repository. 

## Requirements

* Ruby
* Git
* Thor
* Bundler

## Install

Clone the repository to your local machine:

`git clone https://github.com/jeffharrington/sinatra-thor.git

Change to the directory of the project and run:

`thor install sinatra.thor`

After going through the installation process, you will now see the task installed when you run:

`thor installed`

## Usage

Execute the script using Thor as follows:

`thor sinatra:generate ApplicationName`

This will generate a new Sinatra application within a folder that matches the application name. 



