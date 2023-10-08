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

```
terraform apply -var="image_id=ami-abc123"
```

The terraform tfvars file is the default file used to load variables

To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file:
```
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
```
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
```
terraform import <resource_type>.<resource_name> <resource_id>
```

