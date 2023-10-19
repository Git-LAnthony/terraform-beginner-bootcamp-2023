# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler serves as Ruby's reliable package manager, making it the go-to tool for installing Ruby packages, known as gems.

#### Installing Gems

To kickstart the process of installing gems, create a Gemfile and list the gems you require:

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

After you've defined your gem dependencies, execute the bundle install command.

This command globally installs the gems on your system, a departure from Node.js, which installs packages locally in a folder called node_modules. A Gemfile.lock will be generated, which locks down the gem versions for this project.

#### Executing Ruby Scripts in the Context of Bundler

To ensure that future Ruby scripts use the gems we've installed, we must use `bundle exec`. This is the way to set the context.

### Sinatra

Sinatra is a versatile micro web-framework for Ruby that empowers you to build web applications effortlessly.

It excels at creating mock or development servers and is particularly well-suited for straightforward projects.

You can craft a web server using just a single file.

For more information, visit the official website: [Sinatra](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the Web Server

You can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All the code for our server is stored in the `server.rb` file.