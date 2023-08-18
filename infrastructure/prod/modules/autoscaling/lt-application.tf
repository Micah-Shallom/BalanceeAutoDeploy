# launch template for application

resource "aws_launch_template" "application-launch-template" {
  image_id               = var.ami-web
  instance_type          = "t2.micro"
  vpc_security_group_ids = var.web-sg

  iam_instance_profile {
    name = var.instance_profile
  }

  key_name = var.keypair


  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

  tags = merge(
    var.tags,
    {
      Name = "application-launch-template"
    },
  )
  }

#   user_data = filebase64("${path.module}/application.sh")
}