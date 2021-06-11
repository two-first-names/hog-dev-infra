resource "aws_codecommit_repository" "backend" {
  repository_name = "backend"
  default_branch  = "main"
}