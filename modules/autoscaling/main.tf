resource "aws_launch_template" "main" {
  name          = var.name
  image_id      = var.ami    # Make sure to update this with a valid AMI ID
  instance_type = var.instance_type

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.name
    }
  }
}

resource "aws_autoscaling_group" "main" {
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }
  
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.min_size
  vpc_zone_identifier  = var.subnets

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}
