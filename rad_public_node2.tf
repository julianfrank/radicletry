
resource "aws_security_group" "sg_rad_public_node2" {
  name        = "sg_rad_public_node2"
  description = "Security Group for node2"
  vpc_id      = "${aws_vpc.vpc_rad.id}"
  tags        = {    Name = "sg_rad_public_node2"  }
  egress{
    description       = "All egress traffic"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  ingress{
    description       = "All Inbound SSH"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  ingress{
    description       = "All Inbound Ping"
    from_port         = 0
    to_port           = 0
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "i_public_node2" {
    ami               = "${var.ami_ubuntu1804}"
    instance_type     = "${var.type}"
    availability_zone = "us-west-2a"
    key_name          = "${var.ssh_key_name}"
    subnet_id         = "${aws_subnet.sn_public.id}"
    security_groups   = ["${aws_security_group.sg_rad_public_node2.id}"]
    tags              = {    Name = "i_rad_public_node2"  }
    provisioner "remote-exec" {
      inline = [
          "sudo apt update",
          "sudo apt upgrade -y",
          "wget https://storage.googleapis.com/static.radicle.xyz/releases/radicle_latest_amd64.deb",
          "sudo apt install ./radicle_latest_amd64.deb",
          "systemctl --user start radicle-daemon",
          "rad key create",
          "shutdown -r 0",
        ]

      connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = "${file("${var.ssh_key_file_name}")}"
      }
    }
}


output "rad_public_node2" {
  value = "ssh -i \"${aws_instance.i_public_node2.key_name}.pem\" ec2-user@${aws_instance.i_public_node2.public_dns}"
}