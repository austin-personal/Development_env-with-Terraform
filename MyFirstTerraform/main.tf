resource "aws_vpc" "mk_vpc" {
  cidr_block = "10.0.0.0/16" #It is just one of the private IP addresses  

  #These two are false in defualt
  enable_dns_hostnames = true #Instances in the VPC receive public DNS hostnames
  enable_dns_support   = true #Dns resolution = Convert Domain name into IP address

  tags = {
    Name = "MyVPC" #It will show as name in AWS console
  }
}
resource "aws_subnet" "mk_public_subnet" {
  vpc_id                  = aws_vpc.mk_vpc.id
  cidr_block              = "10.0.1.0/24" #Must be inside of VPC cidr block and dont overlap with vpc cidr block
  map_public_ip_on_launch = true #Instances in the subnet will be asiigned with public IP
  availability_zone       = "us-west-2a"

  tags = {
    Name = "dev-public"
  }
}
resource "aws_internet_gateway" "mk_ig" {
  vpc_id = aws_vpc.mk_vpc.id
  tags = {
    Name = "dev-ig"
  }
}
# A collections of rules
resource "aws_route_table" "mk_public_rt" {
  vpc_id = aws_vpc.mk_vpc.id
  tags = {
    Name = "dev-rt"
  }
}
# A route = A rule of outbound traffic
resource "aws_route" "mk_route" {
  route_table_id         = aws_route_table.mk_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mk_ig.id
}
# Assignment of a subnet to a RT. 
resource "aws_route_table_association" "mk_rt-assoc" {
  subnet_id      = aws_subnet.mk_public_subnet.id
  route_table_id = aws_route_table.mk_public_rt.id
}

resource "aws_security_group" "mk_sg" {
  name        = "dev-sg"
  description = "dev-security group"
  vpc_id      = aws_vpc.mk_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["My_IP"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Key-pair is necessary to connect with instances,
resource "aws_key_pair" "deployer" {
  key_name   = "mk_key"
  public_key = file("~/.ssh/mk_key.pub")

}
#Public Key: The public key is placed on the instances when they are launched. It is used to encrypt data and verify the digital signature of the private key.
#Private Key: The private key is kept confidential and should only be stored on your local machine. It is used to decrypt data encrypted by the public key and to digitally sign data.

resource "aws_instance" "mk_ec2" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.id
  vpc_security_group_ids = [aws_security_group.mk_sg.id]
  subnet_id              = aws_subnet.mk_public_subnet.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 9
  }
  provisioner "local-exec" {#The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource.
    command = templatefile("${var.host_os}-ssh-config.tpl",{ #templatefile reads the file at the given path and renders its content as a template using a supplied set of template variables.
      hostname = self.public_ip, #The self Object Expressions in provisioner blocks cannot refer to their parent resource by name. Instead, they can use the special self object. The self object represents the provisioner's parent resource, and has all of that resource's attributes. For example, use self.public_ip to reference an aws_instance's public_ip attribute.
      user = "ubuntu",
      identityfile = "~/.ssh/mk_key"
    })
    interpreter = var.host_os == "linux" ? ["bash", "-c"] : ["Powershell", "Command"]
  }
    tags = {
    name = "dev-node"
  }
}