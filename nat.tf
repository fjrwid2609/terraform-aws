resource "aws_eip" "nat" {
  vpc      = true 
} 
 
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.private.id
} 
 
resource "aws_route_table" "nat" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        "Name" = "NAT"
    }
}
 
resource "aws_route_table_association" "nat" {
  subnet_id = aws_subnet.private.id 
  route_table_id = aws_route_table.nat.id 
} 