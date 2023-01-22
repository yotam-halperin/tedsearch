
// VPC 
resource "aws_vpc" "yh-tf" {
  cidr_block = lookup(var.vpc_cidr, terraform.workspace)

  tags = {
    Name = "${lookup(var.vpc_name, terraform.workspace)}"
  }
}


resource "aws_subnet" "my_subnet" {

  vpc_id            = aws_vpc.yh-tf.id
  cidr_block        = lookup(var.subnet_cidr, terraform.workspace)
  availability_zone = lookup(var.subnet_azs, terraform.workspace)

  tags = {
    Name = "${lookup(var.vpc_name, terraform.workspace)}-sub"
  }
}



// IGW
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.yh-tf.id

  tags = {
    Name = "${lookup(var.vpc_name, terraform.workspace)}-igw"
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