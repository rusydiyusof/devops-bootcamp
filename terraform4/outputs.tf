output "server_id" {
  value = module.my_server_public.id
}

output "rackula_url" {
  value = "http://${module.my_server_public.public_ip}:8080"
}

output "ssm_command" {
  value = "aws ssm start-session --target ${module.my_server_public.id}"
}
