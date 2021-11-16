module "stage" {
  source = "../01_test"

  name   = "shnam"
  region = "ap-northeast-2"
  ava    = ["a", "c"]
  key    = "shnam2-key"
  key_file = "../../.ssh/shnam-key.pub"
  install_sh = "./install.sh"
  cidr_main = "10.0.0.0/16"
  cidr_public = ["10.0.0.0/24", "10.0.2.0/24"]
  cidr_private = ["10.0.1.0/24", "10.0.3.0/24"]
  cidr_privatedb = ["10.0.4.0/24", "10.0.5.0/24"]
  cidr_route = "0.0.0.0/0"
  cidr_ipv6 = "::/0"
  private_ip = "10.0.0.11"
  protocol_ssh = "ssh"
  port_ssh = 22
  protocol_http = "http"
  protocol_http1 = "HTTP"
  port_http = 80
  db_name = "mysql"
  port_mysql = 3306
  protocol_tcp = "tcp"
  protocol_icmp = "icmp"
  port_zero = 0
  protocol_minus = "-1"
  instance = "t2.micro"
  strategy = "cluster"
  storage_size = 20
  storage_type = "gp2"
  sql_engine = "mysql"
  mysql_version = "8.0"
  instance_db = "db.t2.micro"
  name_db = "test"
  username = "admin"
  password = "It12345!"
}
