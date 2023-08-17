
# ---- Autoscaling for application ---------

resource "aws_autoscaling_group" "application-asg" {
  name                      = "application-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.private_subnets


  launch_template {
    id      = aws_launch_template.application-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "balancee-application"
    propagate_at_launch = true
  }
}


# # attaching autoscaling group of  application application to internal loadbalancer
resource "aws_autoscaling_attachment" "asg_attachment_application" {
  autoscaling_group_name = aws_autoscaling_group.application-asg.id
  lb_target_group_arn   = var.application-alb-tgt
}
