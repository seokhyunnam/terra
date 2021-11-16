resource "aws_internet_gateway" "shnam_ig" {
  vpc_id = aws_vpc.shnam_vpc.id
  # vpc_id는 해당 vpc ip에 맞게 변경 되야함
  tags = {
    "Name" = "${var.name}-ig"
  }
}

resource "aws_route_table" "shnam_rf" {
  vpc_id = aws_vpc.shnam_vpc.id
  route {
    cidr_block = var.cidr_route
    gateway_id = aws_internet_gateway.shnam_ig.id
  }
  tags = {
    "Name" = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "shnam_rtas_a" {
  count          = length(var.cidr_public) #두개를 합치기 위한 'count'
  subnet_id      = aws_subnet.shnam_pub[count.index].id
  route_table_id = aws_route_table.shnam_rf.id
}
