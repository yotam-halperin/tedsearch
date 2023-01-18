
// VPC 
resource "aws_vpc" "yh-tf" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.vpc_name}"
  }
}


resource "aws_subnet" "my_subnet" {

  vpc_id            = aws_vpc.yh-tf.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.subnet_azs

  tags = {
    Name = "${var.vpc_name}-sub"
  }
}



// IGW
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.yh-tf.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

// Routing Table
resource "aws_route_table" "vpc-rt" {
  vpc_id = aws_vpc.yh-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
}

resource "aws_main_route_table_association" "main-accosiation" {
  vpc_id         = aws_vpc.yh-tf.id
  route_table_id = aws_route_table.vpc-rt.id
}