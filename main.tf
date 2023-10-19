terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ResumeApp"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "ResumeApp"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="0810103b-1b56-4657-afdf-401d1c2b9cc0" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}
# resource "random_string" "bucket_name" {
#   lower   = true
#   upper   = false
#   length  = 32
#   special = false

# }

# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }

resource "terratowns_home" "home" {
  name = "My fav food"
  description = <<DESCRIPTION
Ramen is a Japanese dish that consists of Chinese-style wheat noodles served in a meat or fish-based broth, 
often flavored with soy sauce or miso, and topped with ingredients such as sliced pork, dried seaweed, green onions, and a half-boiled egg. 
It is a popular and versatile dish with various regional variations and toppings, offering a satisfying and flavorful experience. 
Ramen has gained international popularity and is enjoyed for its rich broth, chewy noodles, and diverse range of accompanying ingredients.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "Cooker Crove"
  content_version = 1
}