resource "aws_key_pair" "web_admin" {
  key_name = "web_admin"
  public_key = file("~/.ssh/web_admin.pub")
}

resource "aws_security_group" "ssh" {
  name = "allow_ssh_from_all"
  description = "Allow SSH port from all"
  ingress {
    # open port range is from 22 to 22
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Load the existing security group with name "default"
data "aws_security_group" "default" {
  name = "default"
}

resource "aws_instance" "web" {
  ami = "ami-e21cc38c" # Amazon Linux AMI 2017.03.1 Seoul
  instance_type = "t2.micro"
  key_name = aws_key_pair.web_admin.key_name
  vpc_security_group_ids = [
    "${aws_security_group.ssh.id}",
    "${data.aws_security_group.default.id}"
  ]
}

resource "aws_db_instance" "web_db" {
  allocated_storage = 8
  engine = "mysql"
  engine_version = "5.6.35"
  instance_class = "db.t2.micro"
  username = "admin"
  password = var.db_password
  skip_final_snapshot = true
}
