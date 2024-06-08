output "docker-instances" {
  value = aws_instance.dev_docker_server.*.id
}