resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_cidr
  availability_zone = "ap-southeast-1a"

  tags = {
    "Name" = "Public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc.id 
  cidr_block = var.private_cidr
  availability_zone = "ap-southeast-1a"
 
  tags = { 
    "Name" = "Private" 
  } 
} 
