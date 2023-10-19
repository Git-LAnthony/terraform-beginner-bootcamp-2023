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

## CRUD
Terraform Provider resources follow the CRUD paradigm, which is an acronym for Create, Read, Update, and Delete. This approach is commonly used to manage resources in information systems and databases. It corresponds to the following actions:

- **Create:** This involves the creation of new resources or records. In the context of Terraform, it typically means provisioning or creating infrastructure components, such as virtual machines, networks, or databases.

- **Read:** This action pertains to querying or retrieving information from existing resources. In Terraform, it involves inspecting the current state of the infrastructure to understand its configuration and status.

- **Update:** Updating implies making modifications or changes to existing resources. Terraform allows you to modify the attributes or settings of resources, enabling you to adapt to evolving requirements.

- **Delete:** Deletion involves the removal of resources that are no longer needed. Terraform enables you to destroy or delete infrastructure components when they are no longer required, which is crucial for resource management and cost control.

This four-fold model is a fundamental concept in resource management and is widely applied in various fields, including software development, database management, and, as mentioned, infrastructure provisioning with Terraform. You can learn more about CRUD on [Wikipedia](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete).