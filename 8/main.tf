// Manage configuration drift

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tfremotestate-vpc"
    key    = "state"            // Path to state file within this bucket
    region = "eu-central-1"     // Change this to the appropriate region
  }
}

data "aws_security_group" "my_sg" {
  id = data.terraform_remote_state.network.outputs.my_sg
}

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
  vpc_security_group_ids = [ data.aws_security_group.my_sg.id ]

  tags = {
    Name = var.name_tag,
  }

  depends_on = [ data.aws_subnets.my_subnets ]
}