### POC READY ###

# Configure the AWS Provider
provider "aws" {
  version    = "~> 2.0"
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

# Security role
resource "aws_security_group" "instance_sec_group" {
  name = "security_group_created_with_terraform"
  ingress {
    description = "web_server_port"
    from_port   = "${var.web_server_port}"
    to_port     = "${var.web_server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh_port"
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "flask_port"
    from_port   = "${var.flask_port}"
    to_port     = "${var.flask_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "ec2_instance" {
  key_name               = "${var.aws_key_name}"
  ami                    = "${var.ami_id}"
  instance_type          = "${var.vm_size}"
  vpc_security_group_ids = [aws_security_group.instance_sec_group.id]
  user_data              = "${file("./scripts/install_docker.sh")}"
  
  tags = {
    Name = "docker_ec2_created_with_terraform"
  }
}

# Runs docker and publishes the flask app
resource "null_resource" "run_sleep_and_docker" {
provisioner "remote-exec" {
	connection {
      type = "ssh"
      user = "ubuntu"
      #private_key = "${file("C:/path/to/pem.pem")}"
      private_key = "${file("${var.aws_private_key_location}")}"
      #password = "${var.root_password}"
      host = "${aws_instance.ec2_instance.public_ip}"
    }
  inline = [
      	 "sleep 120 && sudo docker run -d --network=host --name flask-app-1 elibukin/flaskappimage:flaskapp flask run --host=0.0.0.0 --port=8888",
    	]
  }

  depends_on = [
    aws_instance.ec2_instance,
  ]

}

