// Managing resource dependencies with data sources

data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    //values = ["vpc-0cb1aa34b173b1bb6"]
    values = ["vpc-xxx"] // vpc id that does not exist
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

  depends_on = [ data.aws_subnets.my_subnets ]
}