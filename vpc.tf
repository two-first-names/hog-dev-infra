resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Main VPC"
  }
}

resource "aws_subnet" "dev_vms" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Dev VM Subnets"
  }
}

resource "aws_route_table" "dev_vms" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Dev VMs route table"
  }
}

resource "aws_route_table_association" "dev_vms" {
  subnet_id      = aws_subnet.dev_vms.id
  route_table_id = aws_route_table.dev_vms.id
}