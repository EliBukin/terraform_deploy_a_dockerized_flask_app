output "aws_region" {
  value = "${var.aws_region}"
}

output "aws_security_group" {
  value = "${aws_security_group.instance_sec_group.id}"
}

output "aws_instance_public_ip" {
  value = "${aws_instance.ec2_instance.public_ip}"
}

output "open_ports" {
  value = "${var.web_server_port},${var.ssh_port},${var.flask_port}"
}
