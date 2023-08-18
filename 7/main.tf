// Validate inputs with data sources

variable "instance_ami" {
  description = "Ubuntu AMI in Frankfurt region."
  //default = "ami-065deacbcaac64cf2"
  default = "ami-xxx" // This does not exist
}

data "aws_ami" "selected" {
  most_recent = true

  filter {
    name   = "image-id"
    values = [var.instance_ami]
  }
}

resource "aws_instance" "myec2" {
  ami           = var.instance_ami
  instance_type = "t2.micro"

}
