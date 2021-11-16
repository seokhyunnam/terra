resource "aws_eip" "shnam_eip_ng" {
  vpc = true
}

resource "aws_nat_gateway" "shnam_ng" {
  allocation_id = aws_eip.shnam_eip_ng.id
  subnet_id     = aws_subnet.shnam_pub[0].id
  tags = {
    "Name" = "${var.name}-ng"
  }
  depends_on = [
    aws_internet_gateway.shnam_ig
  ]
}

resource "aws_route_table" "shnam_ngrt" {
  vpc_id = aws_vpc.shnam_vpc.id

  route {
    cidr_block = var.cidr_route
    gateway_id = aws_nat_gateway.shnam_ng.id
  }

  tags = {
    "Name" = "${var.name}-ngrt"
  }
}

resource "aws_route_table_association" "shnam_ngass" {
  count          = length(var.cidr_private)
  subnet_id      = aws_subnet.shnam_pri[count.index].id
  route_table_id = aws_route_table.shnam_ngrt.id
}
