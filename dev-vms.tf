module "jroberts" {
  source = "./modules/dev-vm"

  name      = "jroberts"
  vpc_id    = aws_vpc.main.id
  subnet_id = aws_subnet.dev_vms.id

  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCc2xWD1O8sQbkbhzwdMw/M3NFp6nlr+B17zOY4jDiR4WzeICshhtGnLz4oOG+4pl48Sfg8f+2AFRntFeBOS5WR9x6W1cVEuP0PfrKwNRcDy2rFMZ3leDqgXSrO8Qicl9XfXB+INQNBLJKFBCULPkdlGezY2UF98H4eN8O1hdj1BEHDLgfVju2T1vtl+DS+WugSe0QyYs7NUWbTFArI7gcAKFw6RzWOQUNnUKc+pU6HO93eh8W0St/aQGn9uTwIdArPP4DuwbgiZLY4Vj9m1RtFAnYaV0E7Tqx9DB+mkQzIzvVBO/o9vqcOMM1r4lGnXaqoRKzADOSaMdk3owzoUEAyeFy5uxYKnzzTtKptSkSVgtroDVGh/OUGik0C5S2RlK4kmBtDj/dy4ULIhjlxQjtCs+5MToyLuE/u3d3DPOBxAPzNauZ7AYqgRjU4ZVBIpdHWe1lqeHwRqZv2kKdZMdCDVFkssHOrtFN5KSJzbssQD/wZ6Wdc/04686PHhp6aivc= joeroberts@CIC001612"
}