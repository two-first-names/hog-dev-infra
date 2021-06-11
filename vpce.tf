resource "aws_security_group" "vpce" {
  name = "vpce-sg"

  vpc_id = aws_vpc.main.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-2.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpce.id,
  ]

  subnet_ids = [
    aws_subnet.dev_vms.id
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-2.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpce.id,
  ]

  subnet_ids = [
    aws_subnet.dev_vms.id
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-2.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpce.id,
  ]

  subnet_ids = [
    aws_subnet.dev_vms.id
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-2.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpce.id,
  ]

  subnet_ids = [
    aws_subnet.dev_vms.id
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-2.kms"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpce.id,
  ]

  subnet_ids = [
    aws_subnet.dev_vms.id
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.eu-west-2.s3"

  route_table_ids = [
    aws_route_table.dev_vms.id
  ]
}