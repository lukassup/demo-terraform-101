variable "AWS_ACCESS_KEY" {
  type = "string"
  description = "AWS account access key"
}

variable "AWS_SECRET_KEY" {
  type = "string"
  description = "AWS account secret key"
}

variable "AWS_REGION" {
  type = "string"
  description = "AWS region"
  default = "eu-west-1"
}

provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.AWS_REGION}"
}

resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami           = "ami-00cc9e3eecbef4b46"
  subnet_id     = "subnet-099ce8a0be3521459"

  vpc_security_group_ids = [
    "sg-0139678760bda5d96",
  ]

  tags {
    Identity = "terraform-training-beetle"
    Name     = "beetle"
  }
}

output "public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.public_dns}"
}
