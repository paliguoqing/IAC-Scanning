resource "aws_vpc" "ebilling-vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} VPC"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-vpc"
    yor_trace = "49b7ce2a-fc08-4706-b59e-28ed63f11687"
    git_org   = "paliguoqing"
  }
}
#Internet Gateway
resource "aws_internet_gateway" "ebilling-internet-gateway" {
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Internet Gateway"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-internet-gateway"
    yor_trace = "5903388f-efd7-411d-8950-648e4b1932f7"
    git_org   = "paliguoqing"
  }
}
#Public Subnets
resource "aws_subnet" "ebilling-public-subnet-1" {
  availability_zone = "${var.region}a"
  cidr_block        = "10.10.10.0/24"
  vpc_id            = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Public Subnet #1"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-1"
    yor_trace = "ee87b969-f722-423f-bbc8-4b940aae7288"
    git_org   = "paliguoqing"
  }
}
resource "aws_subnet" "ebilling-public-subnet-2" {
  availability_zone = "${var.region}b"
  cidr_block        = "10.10.20.0/24"
  vpc_id            = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Public Subnet #2"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-2"
    yor_trace = "a7787095-98bd-4148-bc4c-f8057aab4c81"
    git_org   = "paliguoqing"
  }
}
#Public Subnet Routing Table
resource "aws_route_table" "ebilling-public-subnet-route-table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ebilling-internet-gateway.id}"
  }
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Route Table for Public Subnet"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-route-table"
    yor_trace = "b4672a88-91a5-4a31-972b-dd664191f0c3"
    git_org   = "paliguoqing"
  }
}
#Public Subnets Routing Associations
resource "aws_route_table_association" "ebilling-public-subnet-1-route-association" {
  subnet_id      = "${aws_subnet.ebilling-public-subnet-1.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}
resource "aws_route_table_association" "ebilling-public-subnet-2-route-association" {
  subnet_id      = "${aws_subnet.ebilling-public-subnet-2.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}