output "webserver" {
  value = aws_instance.webserver.*.public_ip
}

output "database" {
	value = aws_instance.database.*.public_ip
}
