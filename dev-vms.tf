module "jroberts" {
  source = "./modules/dev-vm"

  name      = "jroberts"
  vpc_id    = aws_vpc.main.id
  subnet_id = aws_subnet.dev_vms.id
}