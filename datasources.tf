data "aws_sns_topic" "this" {
  name = "alarms-topic"
}

data "aws_lb" "alb" {
  name = "${var.alb_name}"
}