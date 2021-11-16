provider "aws" {
  region = var.region
}

resource "aws_key_pair" "shnam_key" {
  key_name = var.key
  #  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDqkYTj49iBV9MP2awZM4zrnbJdjrqparDodjvMrkqNm1TcQME1SVCYgqlLLVtO+2EWtBrguaRns1X8i4jW2vv+aW7vmmjAXphyS8wRNEo1+Z691LLLc21Ymd3w2BN817zL35pDu1GUrTjy46peh5hFpaPn1tA8isMuyhjW11AQfXwRk6VTTCf7N375/A0y+DjwtfZj/lTvCDWxSqgBPXSPOgRC/T4GGPRgA4i11M7v56DBtQzIyUDSgR3Nl+OXY8SxnJYGId8K5RsBlTaM/Czr+w/7sN0Ew9twKOaWMH7EGToQQIzbZuapWTnYWP4z1xCUcKdaJX+rLMwWvW7GuVAFwosfdQ9wEPUMEqG0zmFAitzPxI5ElPZvxpOtsvbT18k2A/ke1uajOwXJGcIzMOKZ9rIN/xoYjQeRAQ8cpiFDFR3pI9+LzsS72gXGzAONFJavV1waeDfNzBtC4JRti+ZCleXT0PdwIf8zby3AuYniU8CEdWQmaikSO9M6YAaG91U="
  public_key = file(var.key_file)
}

resource "aws_vpc" "shnam_vpc" {
  cidr_block = var.cidr_main
  tags = {
    "Name" = "${var.name}-vpc"
  }
}

# 가용영역의 public subnet
resource "aws_subnet" "shnam_pub" {
  count             = length(var.cidr_public) #2
  vpc_id            = aws_vpc.shnam_vpc.id
  cidr_block        = var.cidr_public[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.ava[count.index]}"
  }
}

# 가용영역의 private subnet
resource "aws_subnet" "shnam_pri" {
  count             = length(var.cidr_private)
  vpc_id            = aws_vpc.shnam_vpc.id
  cidr_block        = var.cidr_private[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.ava[count.index]}"
  }
}

# 가용영역의 private DB subnet
resource "aws_subnet" "shnam_pridb" {
  count             = length(var.cidr_privatedb)
  vpc_id            = aws_vpc.shnam_vpc.id
  cidr_block        = var.cidr_privatedb[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pridb${var.ava[count.index]}"
  }
}
