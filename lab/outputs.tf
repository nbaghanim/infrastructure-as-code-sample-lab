output "webservers" {
  value = aws_instance.webserver.*.public_ip
}
output "databases" {
  value = aws_instance.database.*.public_ip
}
