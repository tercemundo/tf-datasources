// Fetching data from remote state file

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tfremotestate-vpc"
    key    = "state"            // Path to state file within this bucket
    region = "eu-central-1"     // Change this to the appropriate region
  }
}

output "pub_subnet_id" {
  value = data.terraform_remote_state.network.outputs.subnet_pub_id
}

output "pri_subnet_id" {
  value = data.terraform_remote_state.network.outputs.subnet_pri_id
}

output "pub_subnet_name" {
  value = data.terraform_remote_state.network.outputs.subnet_pub_name
}

output "pri_subnet_name" {
  value = data.terraform_remote_state.network.outputs.subnet_pri_name
}