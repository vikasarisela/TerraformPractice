resource "aws_vpc" "this" {
  cidr_block       = "192.168.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_terraform"
  }
}

# 1- one way 
# resource "aws_subnet" "subnet1" {             
#     for_each ={"0":"192.168.0.0/27",
#            "1":"192.168.0.32/27",
#            "2":"192.168.0.64/27",
#            "3":"192.168.0.96/27",
#            "4":"192.168.0.128/27",
#            "5":"192.168.0.160/27"}
#    count = 6 
#   vpc_id = aws_vpc.this.id
#   cidr_block = each.value
#   tags = {
#     Name = "Main-${each.key}"   #interpolation if you are using count , Main-${count.index}
#   }

# }
# one way -1 
# variable "subnet_cidr" {
#   type = list(string)
#   ault = [ "192.168.0.0/27","192.168.0.32/27","19\2.168.0.64/27 ", "192.168.0.96/27","192.168.0.128/27","192.168.0.160/27 " ]
# }
#----------------------------------------------------------------------------------------
#subnets for specific Avaialbiltiy zone
# resource "aws_subnet" "subnet1" {             
#     for_each ={"publicsubnet1":"192.168.0.0/27",
#            "privatesubnet1":"192.168.0.32/27",
#            "privatesubnet2":"192.168.0.64/27",}
#     count      = length(var.cidr_subnet)       
#   availability_zone = "us-east-1a"
#   vpc_id = aws_vpc.this.id
#   cidr_block = each.value
#   tags = {
#     Name = "Main-${each.key}"   #interpolation if you are using count , Main-${count.index}
#   }

# }

#-------------------------------------------------------------------
resource "aws_subnet" "sunbet1" {
  count      = length(var.cidr_subnet)
  vpc_id     = aws_vpc.this.id
  cidr_block = element(var.cidr_subnet, count.index)
  tags = {
    Name = "Subnet-${count.index}"

  }

}

variable "cidr_subnet" {
  type        = list(string)
  description = "number of subnets to be created"
  default     = ["192.168.0.0/27", "192.168.0.32/27", "192.168.0.64/27", "192.168.0.96/27", "192.168.0.128/27", "192.168.0.160/27"]

}


