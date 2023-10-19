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
  cloud {
   organization = "ResumeApp"
   workspaces {
     name = "terra-house-1"
   }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}
# resource "random_string" "bucket_name" {
#   lower   = true
#   upper   = false
#   length  = 32
#   special = false

# }
##################################MODULES#####################

##RAMEN MODULE
module "home_ramen_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.ramen.public_path
  content_version = var.ramen.content_version
}

resource "terratowns_home" "home" {
  name = "Ramen - My fav food"
  description = <<DESCRIPTION
Ramen is a Japanese dish that consists of Chinese-style wheat noodles served in a meat or fish-based broth, 
often flavored with soy sauce or miso, and topped with ingredients such as sliced pork, dried seaweed, green onions, and a half-boiled egg. 
It is a popular and versatile dish with various regional variations and toppings, offering a satisfying and flavorful experience. 
Ramen has gained international popularity and is enjoyed for its rich broth, chewy noodles, and diverse range of accompanying ingredients.
DESCRIPTION
  domain_name = module.home_ramen_hosting.domain_name
 # domain_name = "3fdq3gz.cloudfront.net"
  town = "Cooker Crove"
  content_version = var.ramen.content_version
}


##STAR WARS MODULE
module "home_starwars_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.starwars.public_path
  content_version = var.starwars.content_version
}

resource "terratowns_home" "home_starwars" {
  name = "STAR WARS Jedi: Survivor - My fav PS5 game"
  description = <<DESCRIPTION
Developed by the veteran team at Respawn Entertainment, 
Jedi: Survivor will expand upon iconic STAR WARS stories, worlds, and characters, and thrilling combat first experienced in Jedi: Fallen Order.
Cal must stay one step ahead of the Empire’s constant pursuit as he continues to feel the weight of being one of the last remaining Jedi in the galaxy.
DESCRIPTION
  domain_name = module.home_starwars_hosting.domain_name
 # domain_name = "3fdq3gz.cloudfront.net"
  town = "Gamer's Grotto"
  content_version = var.starwars.content_version
}