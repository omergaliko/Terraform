

resource "aws_instance" "instance" {
    ami               = var.ami
    instance_type     = var.instance_type
    key_name          = var.key_name
    availability_zone = var.availability_zone
    tags = {
        Name = var.Tag_name
    }
network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.network_interface.id
}

}


resource "aws_network_interface" "network_interface" {
    subnet_id       = var.subnet_id
    security_groups = [var.security_group]

}
