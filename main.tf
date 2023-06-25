resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Saru"
        terraform = "True"
        Environment = "Dev"
  }
}

resource "aws_vpc" "main" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "Saru"
        terraform = "True"
        Environment = "Dev"
    }
}

resource "aws_subnet" "Public-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
   tags = {
    Name = "Saru_Public-subnet"
        terraform = "True"
        Environment = "Dev"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }


  tags = {
    Name = "Saru_Public-route"
        terraform = "True"
        Environment = "Dev"
  }
}

resource "aws_route_table_association" "Public" {
  subnet_id      = aws_subnet.Public-subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "Private-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
   tags = {
    Name = "Saru_Private-subnet"
        terraform = "True"
        Environment = "Dev"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Saru_Private-route"
        terraform = "True"
        Environment = "Dev"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.Private-subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_subnet" "Database-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
   tags = {
    Name = "Saru_Database-subnet"
        terraform = "True"
        Environment = "Dev"
  }
}

resource "aws_route_table" "Database_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Saru_Database-route"
        terraform = "True"
        Environment = "Dev"
  }
}

resource "aws_route_table_association" "Database" {
  subnet_id      = aws_subnet.Database-subnet.id
  route_table_id = aws_route_table.Database_route_table.id
}

resource "aws_eip" "Nat" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "Nat_gateway" {
  allocation_id = aws_eip.Nat.id
  subnet_id     = aws_subnet.Public-subnet.id
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.Nat_gateway.id
  #depends_on = [aws_route_table.private]
}

resource "aws_route" "Database" {
  route_table_id            = aws_route_table.Database_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.Nat_gateway.id
  #depends_on = [aws_route_table.Database_route_table]
}