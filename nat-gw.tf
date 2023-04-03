resource "aws_eip" "nat-ip" {
  vpc      = true
  depends_on = [aws_internet_gateway.ig]


  tags = merge(
    var.tags,
    {
      Name = format("%s-EIP-%s", var.name, var.environment)
    },
  )
}



resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat-ip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on = [aws_internet_gateway.ig]


  tags = merge(
    var.tags,
    {
      Name = format("%s-Nat-%s", var.name, var.environment)
    },
  )
  
}


