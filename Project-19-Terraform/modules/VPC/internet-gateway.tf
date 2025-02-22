resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.main.id

    tags = merge(
        var.tags, {
            Name = format("%s-%s-%s-!", var.name, aws_vpc.main.id, "ig")
        }
    )
  
}