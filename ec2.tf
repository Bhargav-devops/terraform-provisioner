resource "aws_instance" "web" {
  ami           = "ami-0b4f379183e5706b9" #devops-practice
  instance_type = "t2.micro"

  tags = {
    Name = "Provisioners"
  }

  provisioner "local-exec"{
    command = "echo The server's IP address is ${self.private_ip}" # self = aws_instance.web
  }
}