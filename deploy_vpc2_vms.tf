resource "aws_instance" "pg-vpc2-vm1" {
# TBD
  ami                                  = data.aws_ami.ubuntu.id
  tenancy                              = "default"
  ebs_optimized                        = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "${var.vm_instance_type}"
  key_name                             = "${var.key_name}"
  monitoring                           = false
  vpc_security_group_ids               = [aws_security_group.pg-vpc2-allow-all-sg.id]
  subnet_id                            = aws_subnet.pg-vpc2-workload-az-a-subnet.id
  associate_public_ip_address          = true
  private_ip                           = "${var.pg_vpc2_az_a_workload_vm_ip}"
  source_dest_check                    = false
  tags = {
    Name = "${var.projectPrefix}-az-a-vm2"
  }
  connection {
    user        = "ubuntu"
    private_key = "${var.key_path}"
  }
  user_data = <<EOF
#!/bin/bash
while ! ping -c 1 -n -w 1 8.8.8.8 &> /dev/null;do  printf "%c" "."; sleep 5; done
sudo apt update
sudo apt install nginx  libsctp1 -y 
sudo systemctl enable nginx
sudo systemctl start nginx
echo $(uname -n) > /var/www/html/index.nginx-debian.html
wget https://iperf.fr/download/ubuntu/libiperf0_3.9-1_amd64.deb
wget https://iperf.fr/download/ubuntu/iperf3_3.9-1_amd64.deb
sudo dpkg -i libiperf0_3.9-1_amd64.deb iperf3_3.9-1_amd64.deb
rm libiperf0_3.9-1_amd64.deb iperf3_3.9-1_amd64.deb
EOF
}

resource "aws_instance" "pg-vpc2-jump" {
  ami                                  = data.aws_ami.ubuntu.id
  tenancy                              = "default"
  ebs_optimized                        = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "${var.vm_instance_type}"
  key_name                             = "${var.key_name}"
  monitoring                           = false
  vpc_security_group_ids               = [aws_security_group.pg-vpc2-external-sg.id]
  subnet_id                            = aws_subnet.pg-vpc2-external-subnet.id
  associate_public_ip_address          = true
  source_dest_check                    = false
  tags = {
    Name = "${var.projectPrefix}-vpc2-jump"
  }
  connection {
    user        = "ubuntu"
    private_key = "${var.key_path}"
  }
  user_data = <<EOF
#!/bin/bash
while ! ping -c 1 -n -w 1 8.8.8.8 &> /dev/null;do  printf "%c" "."; sleep 5; done
snap install docker
systemctl enable snap.docker.dockerd
systemctl start snap.docker.dockerd
EOF
}
