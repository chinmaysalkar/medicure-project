resource "aws_instance" "k8s-pro" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.medium"
  key_name               = "myprojetct01"
  vpc_security_group_ids = ["sg-00de37b3b55eb6077"]
  tags = {
    Name = "k8s-pro"
  }
  
  provisioner "local-exec" {
    command = "sleep 60 && echo 'Instance ready'"
  }
  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./myprojetct01.pem")
    host        = self.public_ip 
  }
   
  provisioner "local-exec" {
    command = "echo ${aws_instance.k8s-pro.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/k8s-pro/k8s-pro/deploy.yml"
  }
}
