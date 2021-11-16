resource "aws_ami_from_instance" "shnam_ami" {
  name               = "${var.name}-aws-ami"
  source_instance_id = aws_instance.shnam_web.id

  depends_on = [
    aws_instance.shnam_web #meta argument 이 아이부터 먼저 실행하라
  ]

  tags = {
    "Name" = "${var.name}-ami"
  }
}

resource "aws_launch_configuration" "shnam_aslc" {
  name_prefix          = "${var.name}-web-"
  image_id             = aws_ami_from_instance.shnam_ami.id
  instance_type        = var.instance
  iam_instance_profile = "admin_role"
  security_groups      = [aws_security_group.shnam_sg.id]
  key_name             = var.key
  # user_data = file("./install.sh")

  lifecycle {                    #meta argument
    create_before_destroy = true #업데이트 안되면 삭제하고 다시 만들어라
  }
}

resource "aws_placement_group" "shnam_place" {
  name     = "${var.name}-place"
  strategy = var.strategy
}

resource "aws_autoscaling_group" "shnam_asg" {
  name                      = "${var.name}-asg"
  max_size                  = 10
  min_size                  = 2
  health_check_grace_period = 10
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.shnam_aslc.name
  vpc_zone_identifier       = [aws_subnet.shnam_pub[0].id, aws_subnet.shnam_pub[1].id]
}

resource "aws_autoscaling_attachment" "shnam_asgalbatt" {
  autoscaling_group_name = aws_autoscaling_group.shnam_asg.id
  alb_target_group_arn   = aws_lb_target_group.shnam_albtg.arn
}
