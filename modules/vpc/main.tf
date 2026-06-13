resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
tags = merge(var.tags,{
  Name = format("%s-vpc",var.tags["application"])
})
}

data "aws_availability_zones" "az_info" {
  state = "available"
}
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr)
  availability_zone = element(data.aws_availability_zones.az_info.names, count.index)
  vpc_id            = aws_vpc.main.id
  tags = merge(var.tags, {
    Name = format("%s-private-subnet-%s", var.tags["Organization"], var.private_subnet_cidr[count.index])
  })

}  


resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = resource.aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = element(var.availability_zone,count.index)
  tags = merge(var.tags,{
  Name = format("%s-private-subnet-%s",var.tags["application"],var.private_subnet_cidr[count.index])
})

}  

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = resource.aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = element(var.availability_zone,count.index)
  tags = merge(var.tags,{
  Name = format("%s-public-subnet-%s",var.tags["application"],var.public_subnet_cidr[count.index])
})
  } 

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route  = []
  tags = merge(var.tags, {
    Name = format("%s-main-route-table-%s", var.tags["application"], var.environment)
    Env  = var.environment
    })
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.main.id  
  route = []
  tags = merge(var.tags, {
  Name = format("%s-nat-route-table-%s", var.tags["application"], var.environment)
    env = var.environment
  }
  )
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public[0].id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private[0].id
  route_table_id = aws_route_table.nat.id

}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags,{
   Name = format("%s-internet_gateway-%s", var.tags["application"], var.environment)
    env  = var.environment
  })
  
}

resource "aws_route" "igw" {
  route_table_id = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id

}
 
resource "aws_eip" "this" {
  domain = "vpc"
  
}

  resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.this.id
   subnet_id = aws_subnet.public[0].id
    tags = merge(var.tags,{
      Name = format("%s-nat_gateway-%s", var.tags["application"], var.environment)
      env = var.environment
    })

  }
    
    resource "aws_route" "nat"{
      route_table_id = aws_route_table.nat.id
      destination_cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main.id
    }

    














