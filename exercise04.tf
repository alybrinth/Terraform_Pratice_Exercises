#A declaration of required providers, specifically the AWS provider from HashiCorp.

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
  
}



#second "my_bucket" is the lable for our s3 bucket
#this will be used to reference to this bucket in future
#This one is actively being managed by us, by our terraform project
resource "aws_s3_bucket" "my_bucket" {
    bucket = var.bucket_name
    #syntax is of the form
    #identifyer and an expression (which evaluates to something in the end)
  
}


#at times we need to retrieve some infrastructure that is not managed by us
#thats where data block comes in.
#is managed somewhere else, we just wanna use it in our project
data "aws_s3_bucket" "my_external_bucket" {
    bucket = "not_managed_by_us"
}


#veriables are like function parameters
#used so that we can go for customization
variable "bucket_name" {
    type = string
    #is the type of veriable

    #provides description of what the veriable is for
    description = "My veriable used to set bucket name"

    #provide a default value for our bucket name
    default = "MyS3buuuccckkkettt"
}
#usage of veriable is 
# var.veriable_name (in our case var.bucket_name)


#output block is used to expose the information to the outside world
#just like veriable block the output block as well contains a lable.
output "bucket_id" {
    #here the thing we are going to expose/output will be a value
    #this could be data from (aka we can retrieve this value from) data sources, resources or even from veriables.
    value = aws_s3_bucket.my_bucket.id
}

#sometimes theres complex information that we want to process
#for eg we want to filter something or do some processing in some data structure so that we have info that easier to work with.
#locals block allows us to create "temperory veriables", this are the veriables that we might create temperory inside a function body
#to help us write code but we are not returning them and we are not recieving them as parameters somewhere.
locals {
  local_example = "this is a local veriable example" 
}
#we can also provide the value of locals as outputs
#so in output block we will have something like : value = local.local_example
#This to note we hace .local and its singular and noplural locals.

#a module is a piece of resuable code, that we can import into our current terraform project
#has a lable "my_module" (for eg)
module "my_module" {
    source = "./module-example"
    #here the module-example would be a folder in our current directory aka the terraform folder
}
