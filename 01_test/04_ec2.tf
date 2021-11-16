resource "aws_security_group" "shnam_sg" {
  name        = "Allow Basic"
  description = "Allow HTTP,SSH,SQL,ICMP"
  vpc_id      = aws_vpc.shnam_vpc.id

  ingress = [
    {
      description      = var.protocol_http
      from_port        = var.port_http
      to_port          = var.port_http
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = var.protocol_ssh
      from_port        = var.port_ssh
      to_port          = var.port_ssh
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = var.db_name
      from_port        = var.port_mysql
      to_port          = var.port_mysql
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = var.protocol_icmp
      from_port        = var.port_zero
      to_port          = var.port_zero
      protocol         = var.protocol_icmp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
  egress = [
    {
      description      = "ALL"
      from_port        = var.port_zero
      to_port          = var.port_zero
      protocol         = var.protocol_minus
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }

  ]
  tags = {
    Name = "${var.name}_sg"
  }
}



# data "aws_ami" "amzn" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["amazon"]
# }

resource "aws_instance" "shnam_web" {
  ami               = "ami-04e8dfc09b22389ad" #"ami-04e8dfc09b22389ad"
  instance_type     = var.instance
  key_name          = var.key
  availability_zone = "${var.region}${var.ava[0]}"
  # private_ip           = var.private_ip
  subnet_id              = aws_subnet.shnam_pub[0].id #public_subnet 1의 id
  vpc_security_group_ids = [aws_security_group.shnam_sg.id]
  user_data              = file(var.install_sh) #워드프레스 관련 문서파일을 해당 위치로 위치시키고

  tags = {
    "Name" = "${var.name}-web"
  }

}
resource "aws_eip" "shnam_web_eip" {
  vpc      = true
  instance = aws_instance.shnam_web.id
  # associate_with_private_ip  = var.private_ip
  depends_on = [
    aws_internet_gateway.shnam_ig
  ]
}

output "public_ip" {
  value = aws_instance.shnam_web.public_ip
}
