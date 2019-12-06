resource "aws_cloudwatch_metric_alarm" "alb" {
  count                     = length(var.alb_alarms)
  alarm_name                = format("%s_%s", var.alb_name, lookup(element(var.alb_alarms, count.index), "metric_name"))
  comparison_operator       = lookup(element(var.alb_alarms, count.index), "comparison_operator")
  evaluation_periods        = lookup(element(var.alb_alarms, count.index), "evaluation_periods")
  metric_name               = lookup(element(var.alb_alarms, count.index), "metric_name")
  namespace                 = lookup(element(var.alb_alarms, count.index), "namespace")
  period                    = lookup(element(var.alb_alarms, count.index), "period")
  statistic                 = lookup(element(var.alb_alarms, count.index), "statistic")
  threshold                 = lookup(element(var.alb_alarms, count.index), "threshold")
  alarm_description         = lookup(element(var.alb_alarms, count.index), "alarm_description")
  alarm_actions             = [data.aws_sns_topic.this.arn]
  insufficient_data_actions = []

  dimensions = contains(keys(element(var.alb_alarms, count.index)), "dimensions") ? merge(lookup(element(var.alb_alarms, count.index), "dimensions"), {LoadBalancer = data.aws_lb.alb.id}) : {LoadBalancer = data.aws_lb.alb.id}
}