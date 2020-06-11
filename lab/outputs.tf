output "address" {
  value = "${aws_elb.lab_elb_web.dns_name}"
}
