output "aws_vpc" {
  value = aws_vpc.vpc.id
}

output "aws_subnet_public" {
  value = aws_subnet.public_subnet.id
}

output "aws_subnet_private" {
  value = aws_subnet.private_subnet.id
}