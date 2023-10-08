# Terraform Beginner Bootcamp 2023 - WEEK 1:

## Terraform module structure
The [Terraform module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure) is a file and directory layout recommended for reusable modules distributed in separate repositories.

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

