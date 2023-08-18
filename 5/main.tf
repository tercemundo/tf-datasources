// Creating dynamic configuration with data sources

data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0cb1aa34b173b1bb6"]
  }
}

resource "aws_instance" "my_vm_2" {
  for_each      = toset(data.aws_subnets.my_subnets.ids)
  ami           = var.ami //Ubuntu AMI
  instance_type = var.instance_type

  subnet_id = each.key

  tags = {
    Name = var.name_tag,
  }
}

// Optionally
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tfremotestate-vpc"
    key    = "state"        // Path to state file within this bucket
    region = "eu-central-1" // Change this to the appropriate region
  }
}

resource "aws_instance" "my_vm" {
  for_each      = toset(data.terraform_remote_state.network.outputs.subnets)
  ami           = var.ami //Ubuntu AMI
  instance_type = var.instance_type

  subnet_id = each.key

  tags = {
    Name = var.name_tag,
  }
}
