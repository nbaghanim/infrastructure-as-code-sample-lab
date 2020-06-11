output "address" {
  value = "${aws_elb.lab_elb_web.dns_name}"
}

output "nodes" {
	value = aws_instance.lab_nodes.*.public_ip
}
