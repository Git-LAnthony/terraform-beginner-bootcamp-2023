# Terraform Beginner Bootcamp 2023 - WEEK 1:

## Terraform module structure
The [Terraform module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure) is a file and directory layout recommended for reusable modules distributed in separate repositories.
```
Project root(.)
|
├── README.md
├── main.tf  # The main configuration file for the module
├── variables.tf  # Input variable definitions
├── outputs.tf  # Output variable definitions
├── providers.tf   #providers and their configurations
├── ...
├── modules/
│   ├── nestedA/
│   │   ├── README.md
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   ├── nestedB/
│   ├── .../
├── examples/
│   ├── exampleA/
│   │   ├── main.tf
│   ├── exampleB/
│   ├── .../
```

## Migrate Terraform state file
We successfully migrated the terrform state file to our local repository by fist destroying the already deployed resource in AWS and then deleting the local `lock.hcl` file and terraform folder. 
Follow [terraform cloud migration guide](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate) on how to migrate your local state file to terraform cloud.
Here are blog posts on how to migrate from cloud to local state storage
- [Harshicorp Migration Issue 332214](https://github.com/hashicorp/terraform/issues/33214)
-[Nerinthecloud.com](https://nedinthecloud.com/2022/03/03/migrating-state-data-off-terraform-cloud/)
## Terraform variables
There are two types of terraform variables.
- Environment variables: These are variables that are stored in the CLI or bash interface eg is AWS or Azure credentials
- Terraform variables: These are variables that are set in the tfvars file

### Terraform Input variables
When variables are declared in the root module of your configuration, they can be set in a number of ways:

- In a Terraform Cloud workspace.
- Individually, with the -var command line option.
- In variable definitions (.tfvars) files, either specified on the command line or automatically loaded.
- As environment variables.

To specify individual variables on the command line, use the -var option when running the terraform plan and terraform apply commands:

```hcl
terraform apply -var="image_id=ami-abc123"
```

The terraform tfvars file is the default file used to load variables

To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file:
```hcl
terraform apply -var-file="testing.tfvars"
```

If the same variable is assigned multiple values, Terraform uses the last value it finds, overriding any previous values. Note that the same variable cannot be assigned multiple values within a single source.

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables
- The terraform.tfvars file, if present.
- The terraform.tfvars.json file, if present.
- Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
- Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

Visit [terraform document on input variables](https://developer.hashicorp.com/terraform/language/values/variables) for more information.

### Terraform Output variables
Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use.

Each output value exported by a module must be declared using an output block:
```hcl
output "instance_ip_addr" {
  value = aws_instance.server.private_ip
}
```
Visit [terraform document on output variables](https://developer.hashicorp.com/terraform/language/values/outputs) for more information.


## Dealing with Terraform drift
To fix configuration drift in Terraform:

1. Identify drift using `terraform plan`.
2. Review the proposed changes.
3. Resolve drift by updating your Terraform configuration or importing resources.
4. Apply the changes with `terraform apply`.
5. Repeat steps 1-4 until there's no drift.
6. Enforce a "Terraform only" policy for changes.
7. Consider automation and monitoring to prevent future drift.

### Fixing missing resources with Terraform import
Terraform can import existing infrastructure resources. This functionality lets you bring existing resources under Terraform management.
```hcl
terraform import <resource_type>.<resource_name> <resource_id>
```

## Terraform Modules

It is recommended to place modules in a "modules" directory when developing modules locally, but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module. The module has to declare the Terraform variables in its own "variables.tf" file.

```hcl
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

###Module Sources

Using the "source" attribute, we can import the module from various places, such as:

- Locally
- GitHub
- Terraform Registry

```hcl
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

Visit [terraform document on module source](https://developer.hashicorp.com/terraform/language/modules/sources) for more information.

## Terraform S3 Static Website hosting
To enable static website hosting on AWS S3 bucket the [aws_s3_bucket_website_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) resource is used.
```hcl
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}
```
It is important to remember that most AI tools are not usually up to date and Terraform are periodically making updates to their providers therefore it is important to rely on Terraform documentation.

### Uploading objects to S3 bucket
To upload index.html and error.html files to an AWS S3 bucket using Terraform, you need to create the [aws_s3_bucket_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) resource. Examle
```hcl
resource "aws_s3_bucket_object" "object" {
  bucket = "your_bucket_name"
  key    = "new_object_key"
  source = "path/to/file"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("path/to/file")
}
```

### Specifying the file path
The [source argument](https://developer.hashicorp.com/terraform/language/modules/sources) in a module block tells Terraform where to find the source code for the desired child module.

In terraform you can specify the path to a file by using the special `path` variable.
You can visit [Terraform documentation on reference variable](https://developer.hashicorp.com/terraform/language/expressions/references) for more information. For example
```hcl
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.website_example
  key    = "index.html"
  source = "path/to/file"
}
```

### Terraform Fileexists function
[fileexists](https://developer.hashicorp.com/terraform/language/functions/fileexists) determines whether a file exists at a given path. Functions are evaluated during configuration parsing rather than at apply time, so this function can only be used with files that are already present on disk before Terraform takes any actions. For example

```hcl
variable "file_example" {
  description = "The file path for the file"
  type        = string

  validation {
    condition     = fileexists(var.file_example_path)
    error_message = "The provided path for file_example does not exist."
  }
}
```
### Terraform Locals: Defining and Utilizing Local Variables

Locals enable us to define and employ local variables, making them invaluable when we need to transform data into another format and make reference to a variable.

```hcl
locals {
  s3_origin_id = "MyS3Origin"
}
```

Visit [Terraform documentation on Local Values](https://developer.hashicorp.com/terraform/language/values/locals) for more information.

### Terraform Data Sources: Accessing Cloud Resource Data

Data sources permit us to access data from cloud resources, providing a convenient way to reference cloud resources without the need to import them explicitly.
Visit [Terraform documentation on Data Sources](https://developer.hashicorp.com/terraform/language/data-sources) for more information.

```hcl
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

### Working with JSON in HCL

We utilize [jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode) to create JSON policies inline within the HCL code.

Example:

```hcl
jsonencode({
  "hello" = "world"
})
```

Result:

```json
{"hello": "world"}
```

### Lifecycle of Resources
The [lifecycle meta-argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle) in Terraform is used to customize how resources are managed from creation to destruction. It includes options like "create_before_destroy" for resource replacement, "prevent_destroy" to make resources immutable, "ignore_changes" to specify attributes to ignore during updates, custom timeouts, and "create_before_destroy_timeout" for controlling the timeout of resource creation during updates. This meta-argument allows for precise control over resource management in Terraform.

### Terraform `replace_triggered_by`
The [replace_triggered_by](https://developer.hashicorp.com/terraform/language/resources/terraform-data) lifecycle argument requires all of the given addresses to be for resources, because the decision to force replacement is based on the planned actions for all of the mentioned resources.

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

### Terraform provisioners
[Terraform provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax) are features in Terraform, a popular infrastructure as code tool, that enable you to execute actions on resources after they've been created or updated. There are two main types: 
- [local-exec provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec) for running commands on the local machine.
```hcl
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}

```
- [remote-exec provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec) for running commands on the remote resources.
```hcl
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```
While provisioners can be useful for specific tasks, they should be used carefully as they can add complexity and are not a replacement for dedicated configuration management tools like Ansible or Puppet.

### Teraform Heredoc
Terraform also supports a [heredoc](https://developer.hashicorp.com/terraform/language/expressions/strings#heredoc-strings) style of string literal inspired by Unix shell languages, which allows multi-line strings to be expressed more clearly. For example
```
<<EOT
hello
world
EOT

```
## Uploading files to S3 bucket using Terraform
When uploading files to S3 bucket the "aws_s3_object" resource is used. For example
```hcl
resource "aws_s3_object" "object" {
  bucket = "your_bucket_name"
  key    = "new_object_key"
  source = "path/to/file"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("path/to/file")
}
```
Visit terraform documentation on [uploading objects to AWS S3 bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object.html) for more information.

### For_each Expression
Terraform uses either count or for_each to enumerate over data-tyoes. When you have a lsit of files to be uploaded it is best to use a for_each meta-argument. If a resource or module block includes a for_each argument whose value is a map or a set of strings, Terraform creates one instance for each member of that map or set. For example
```hcl
resource "azurerm_resource_group" "rg" {
  for_each = {
    a_group = "eastus"
    another_group = "westus2"
  }
  name     = each.key
  location = each.value
}

```
Visit terraform documentation on [For_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each) for more information.
