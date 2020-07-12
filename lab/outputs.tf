output "nodes" {
  value = aws_instance.lab_nodes.*.public_ip
}
