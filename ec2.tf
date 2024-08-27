resource "aws_instance" "web" {
  ami           = "ami-0b4f379183e5706b9" #devops-practice
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.roboshop-all.id]
  tags = {
    Name = "Provisioners"
  }

  provisioner "local-exec"{
    command = "echo This will execute at the time of creation ${self.private_ip}" # self = aws_instance.web
  }
  provisioner "local-exec"{
    command = "echo ${self.private_ip} > inventory" # self = aws_instance.web
  }
  # provisioner "local-exec"{
  #   command = "ansible-playbook -i inventory web.yaml" # self = aws_instance.web
  # }

  connection {
    type     = "ssh"
    user     = "root"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'this is from remote-exec' > /tmp/bhargav.txt",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx"
    ]
  }
}

resource "aws_security_group" "roboshop-all" {
  name        = "Provisioners"

  ingress {
    description = "allow ssh "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow nginx port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Provisioners"
  }
}