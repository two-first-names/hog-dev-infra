data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-arm64-gp2"]
  }
}

resource "aws_ebs_volume" "dev" {
  availability_zone = "eu-west-2a"
  size              = 30
}

resource "aws_instance" "dev" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  security_groups = [aws_security_group.sg.id]

  iam_instance_profile = aws_iam_instance_profile.dev.id

  tags = {
    Name  = var.name
    Owner = var.name
    Type  = "DevVM"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  name = "${var.name}_dev_vm"
}

resource "aws_volume_attachment" "dev" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.dev.id
  instance_id = aws_instance.dev.id
}

resource "aws_iam_instance_profile" "dev" {
  name = "${var.name}_dev_vm"
  role = aws_iam_role.dev.name
}

resource "aws_iam_role" "dev" {
  name                = "${var.name}_dev_vm"
  assume_role_policy  = data.aws_iam_policy_document.instance-assume-role-policy.json
  managed_policy_arns = [aws_iam_policy.dev.arn]
}

resource "aws_iam_policy" "dev" {
  name        = "${var.name}_dev_vm"
  description = "Permit the EC2 instance to receive connections via Session Manager"

  path   = "/"
  policy = data.aws_iam_policy_document.dev.json
}

data "aws_iam_policy_document" "dev" {
  statement {
    sid = "AllowSessionManager"

    actions = [
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:CreateControlChannel",

      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply",

      "ssm:GetDocument",
      "ssm:DescribeDocument",
      "ssm:DescribeAssociation",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation"
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
