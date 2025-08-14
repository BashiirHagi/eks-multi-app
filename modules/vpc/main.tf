resource "aws_vpc" "main" { 
  cidr_block = var.vpc_cidr
  tags = {
    Environment = var.environment
    Name        = "${var.environment}-vpc"
  }
}
resource "aws_subnet" "public" {
  for_each          = { for index, cidr in var.public_subnets : index => cidr } //
  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.availability_zones, each.key)
  cidr_block        = each.value
  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-public-subnet-${each.key}",
    }
  )
}
resource "aws_subnet" "private" {
  for_each          = { for index, cidr in var.private_subnets : index => cidr } //
  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.availability_zones, each.key)
  cidr_block        = each.value
  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-private-subnet-${each.key}",
    }
  )
}
## public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.environment}-public-rt"
  }
}
## route table association public
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
## private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "${var.environment}-private-rt"
  }
}
## route table association private
resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    Name = "${var.environment}-eip"
  }
}
resource "aws_nat_gateway" "ngw" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.public[0].id
  allocation_id     = aws_eip.eip.id
  depends_on        = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.environment}-nat-gateway"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  tags = {
    Name = "${var.environment}-vpc-endpoint"
  }
}
###VPC Flow logs + S3 storage 
resource "aws_s3_bucket" "logging" {
  bucket = var.s3_logging_bucket
  tags = {
    Name = "${var.environment}-bucket"
  }
}
resource "aws_flow_log" "flow_log" {
  vpc_id               = aws_vpc.main.id
  log_destination      = aws_s3_bucket.logging.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  tags = {
    Name = "${var.environment}-flow-log"
  }
}
