// create instances
resource "aws_instance" "instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.my_subnet.id

  associate_public_ip_address = true
  key_name      = "yh"
  # user_data = file("user_data.sh")

  iam_instance_profile = aws_iam_instance_profile.yh-profile.name
  
  tags = {
    Name = "${var.vpc_name}-instance"
  }
}

output "publicip" {
  value = aws_instance.instance.public_ip
}

resource "null_resource" "copy_execute" {
  
    connection {
      type = "ssh"
      host = aws_instance.instance.public_ip
      user = "ubuntu"
      private_key = file("yh.pem")
    }
    # provisioner "file" {
    #   source      = "app"
    #   destination = "app"
    # }
    provisioner "file" {
      source      = "user_data.sh"
      destination = "user_data.sh"
    }
    provisioner "file" {
      source      = "docker-compose.yml"
      destination = "docker-compose.yml"
    }
    provisioner "file" {
      source      = "nginx"
      destination = "nginx"
    }
    provisioner "file" {
      source      = "target/classes/static"
      destination = "static"
    }
    provisioner "remote-exec" {
      inline = [
      "bash ./user_data.sh",
      ]
    }
  
  depends_on = [ aws_instance.instance ]
  
  }

// create the security group for the instances
resource "aws_security_group" "sg" {
  name   = "${var.vpc_name}-sg-instance"
  vpc_id = aws_vpc.yh-tf.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.instance_port
    to_port     = var.instance_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

// ###########################################
#Create an IAM Policy
resource "aws_iam_policy" "yh-policy" {
  name        = "yh-Policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
  })
}

#Create an IAM Role
resource "aws_iam_role" "yh-role" {
  name = "yh_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
  })
}

resource "aws_iam_policy_attachment" "yh-attach" {
  name       = "yh-attachment"
  roles      = [aws_iam_role.yh-role.name]
  policy_arn = aws_iam_policy.yh-policy.arn
}

resource "aws_iam_instance_profile" "yh-profile" {
  name = "yh_profile"
  role = aws_iam_role.yh-role.name
}


