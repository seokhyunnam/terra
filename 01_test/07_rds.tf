resource "aws_db_instance" "shnam_mydb" {
  allocated_storage      = var.storage_size
  storage_type           = var.storage_type
  engine                 = var.sql_engine
  engine_version         = var.mysql_version
  instance_class         = var.instance_db
  name                   = var.name_db
  identifier             = var.name_db
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.mysql8.0"
  availability_zone      = "${var.region}${var.ava[0]}"
  db_subnet_group_name   = aws_db_subnet_group.shnam_dbsn.id
  vpc_security_group_ids = [aws_security_group.shnam_sg.id]
  skip_final_snapshot    = true
  tags = {
    "Name" = "${var.name}-${var.name_db}"
  }
}

resource "aws_db_subnet_group" "shnam_dbsn" {
  name       = "shnam-dbsb-group"
  subnet_ids = [aws_subnet.shnam_pridb[0].id, aws_subnet.shnam_pridb[1].id]
  tags = {
    Name = "${var.name}-dbsb-group"
  }
}
